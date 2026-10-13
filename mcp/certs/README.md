# Private CA / client certificates

Put the PEM file(s) for your Kafka brokers' private CA here (for example `ca.pem`). This directory is mounted
read-only at `/certs` inside the `kafka-mcp` container. Then set in `mcp/.env`:

```
KAFKA_TLS_ENABLE=true
KAFKA_CA_CERT_FILE=/certs/ca.pem
```

Files in this directory (except this README) are git-ignored. See `docs/connect-kafka.md`.
