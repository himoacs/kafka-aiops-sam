# Point the Kafka MCP server at your cluster

The cluster agent talks to Kafka through [tuannvm/kafka-mcp-server](https://github.com/tuannvm/kafka-mcp-server)
(pinned at 2.0.2). The server is an ordinary Kafka client: it needs bootstrap servers, credentials and, for TLS
clusters, trust in your CA. Everything is configured in `mcp/.env`; `mcp/docker-compose.yaml` passes it through.

## 1. Create a describe-only principal

Do this first, so a mistake in a prompt can never become a write. Commands: [../reference/acl-readonly.md](../reference/acl-readonly.md).
The exposed tools need only `Describe` and `DescribeConfigs` on the cluster, topics and groups. Never give this
principal `Read`, `Write`, `Alter`, `Create` or `Delete`.

## 2. Fill in `mcp/.env`

| Variable | Meaning |
|---|---|
| `KAFKA_BROKERS` | comma-separated bootstrap servers **as reachable from inside the container** |
| `KAFKA_SASL_MECHANISM` | `plain`, `scram-sha-256` or `scram-sha-512`; empty means no SASL |
| `KAFKA_SASL_USER`, `KAFKA_SASL_PASSWORD` | the describe-only principal's credentials |
| `KAFKA_TLS_ENABLE` | `true` for TLS or SASL_SSL listeners |
| `KAFKA_CA_CERT_FILE` | in-container path to a private CA PEM, for example `/certs/ca.pem` |
| `KAFKA_TLS_INSECURE_SKIP_VERIFY` | development only; leave `false` |
| `KAFKA_CLIENT_ID` | client id shown in broker logs and quotas (default `kafka-mcp-server`) |

`localhost` inside the container is the container itself. For a Kafka on the same machine use
`host.docker.internal:<port>` (the compose file maps it on Linux too), and make sure the broker's
**advertised listeners** use a name the container can resolve, because clients reconnect to the advertised address.

### Common setups

| Your cluster | Settings |
|---|---|
| Local or lab, PLAINTEXT | `KAFKA_BROKERS` only |
| TLS only, public CA | `KAFKA_TLS_ENABLE=true` |
| SASL_SSL, SCRAM-SHA-512, **private CA** (our tested setup) | `KAFKA_SASL_MECHANISM=scram-sha-512`, user and password, `KAFKA_TLS_ENABLE=true`, drop `ca.pem` into `mcp/certs/`, `KAFKA_CA_CERT_FILE=/certs/ca.pem` |
| SASL_PLAINTEXT with PLAIN | `KAFKA_SASL_MECHANISM=plain`, user and password (plain over an unencrypted listener sends the password in clear text; prefer TLS) |
| Amazon MSK with SCRAM | like SASL_SSL with SCRAM, public Amazon CA: `KAFKA_TLS_ENABLE=true`, no CA file |
| Confluent Cloud, Aiven and similar API-key or SASL/PLAIN over TLS | SASL `plain` with the key and secret, `KAFKA_TLS_ENABLE=true` |

Only the SCRAM-SHA-512 private-CA setup was tested by us. The rest follow from the server's documented settings
and are **untested**.

**Not listed as supported by the server's README (version 2.0.2):** mutual TLS (client certificates), Kerberos
(GSSAPI), and OAUTHBEARER. The README documents no variables for client certificates or a CA file; we trust a
private CA through the Go runtime's `SSL_CERT_FILE`, which is what `KAFKA_CA_CERT_FILE` sets. Note that this
**replaces** the container's trusted roots, so if you need both a private CA and public CAs, put both in one
bundle file. If you need mTLS or OAUTHBEARER, check newer releases of the server and change the image tag.

## 3. Start it and verify

```bash
cd mcp && docker compose up -d kafka-mcp && cd ..
mcp/scripts/mcp-smoke.sh http://localhost:9201/mcp cluster_overview
```

The first line lists the tools the server offers (nine: `produce_message`, `consume_messages`, `list_brokers`,
`describe_topic`, `list_topics`, `list_consumer_groups`, `describe_consumer_group`, `describe_configs`,
`cluster_overview`). The second shows your cluster.

Troubleshooting: `docker compose logs kafka-mcp`. Typical causes: brokers not resolvable from the container,
advertised listeners pointing at an unreachable name, a TLS handshake failure (CA not trusted), or SASL
authentication failure (wrong mechanism, wrong password).

## 4. What the agents are allowed to use

The server offers `produce_message` and `consume_messages`, but `sam/connectors/kafka_mcp.yaml` hides them:

```yaml
allow_list: "cluster_overview,list_brokers,list_topics,describe_topic,describe_configs,list_consumer_groups,describe_consumer_group"
```

That is the second layer. The first layer is the ACLs above: even if someone called the MCP port directly and
asked to produce, Kafka would deny it. Keep both.

## 5. Docker networks and where SAM runs

- **SAM on the same machine** (desktop app): the defaults work; `KAFKA_MCP_URL` stays `http://localhost:9201/mcp`.
- **SAM in a container or elsewhere:** point `KAFKA_MCP_URL` in `sam/.env` at an address SAM can reach.
- **Kafka (or Prometheus/Loki) only reachable on a Docker network:** add that network to the services in a
  `mcp/docker-compose.override.yaml`:
  ```yaml
  services:
    kafka-mcp:
      networks: [default, my-kafka-net]
  networks:
    my-kafka-net: {external: true}
  ```
  then use the service names on that network in `mcp/.env`.
- **Kubernetes:** run the same images as a Deployment with the same environment variables and a ClusterIP
  Service; keep it off public ingress ([security.md](security.md)).

## Kubernetes/Strimzi clusters

If Kafka runs on Strimzi, create a `KafkaUser` for the principal with only the ACLs above (Describe,
DescribeConfigs) and mount its secret into the MCP deployment. Not tested.
