# A describe-only Kafka principal for the MCP server

The Kafka MCP server connects as an ordinary Kafka client. **Enforce read-only in Kafka, not in a prompt:** give it
a principal that is only allowed to describe things. Even if an agent (or someone who can reach the MCP port)
asked for a write, Kafka itself would refuse.

These are the ACLs we run it with. They cover everything the exposed tools need (`cluster_overview`,
`list_brokers`, `list_topics`, `describe_topic`, `describe_configs`, `list_consumer_groups`,
`describe_consumer_group`) and nothing else: no Read, no Write, no Alter, no Create, no Delete.

```bash
P=User:mcp-reader     # your principal name; with mTLS it is the certificate DN, e.g. User:CN=mcp-reader

kafka-acls.sh --bootstrap-server $BOOTSTRAP --command-config admin.properties --add \
  --allow-principal $P --operation Describe --operation DescribeConfigs --cluster
kafka-acls.sh --bootstrap-server $BOOTSTRAP --command-config admin.properties --add \
  --allow-principal $P --operation Describe --operation DescribeConfigs --topic '*'
kafka-acls.sh --bootstrap-server $BOOTSTRAP --command-config admin.properties --add \
  --allow-principal $P --operation Describe --group '*'
```

Create the user first if you use SCRAM, for example:

```bash
kafka-configs.sh --bootstrap-server $BOOTSTRAP --command-config admin.properties --alter \
  --add-config 'SCRAM-SHA-512=[password=CHANGE_ME]' --entity-type users --entity-name mcp-reader
```

Check the result:

```bash
kafka-acls.sh --bootstrap-server $BOOTSTRAP --command-config admin.properties --list --principal $P
```

Notes
- This assumes `StandardAuthorizer` (KRaft). If your cluster has no authorizer, anyone who can connect can do
  anything, so the MCP server's tool allow-list (`sam/connectors/kafka_mcp.yaml`) is then your only guard.
  Turn on ACLs before pointing agents at a production cluster.
- On a cluster that denies by default (`allow.everyone.if.no.acl.found=false`) topic and group names you do not
  grant here are invisible to the principal, which is the intended behavior.
- `consume_messages` would need `Read` on topics (reading message payloads). We deliberately do not grant it and
  the connector does not expose that tool; payloads can contain personal data.
