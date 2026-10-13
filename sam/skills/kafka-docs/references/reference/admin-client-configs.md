---
title: Admin client configs
source_url: https://kafka.apache.org/42/configuration/admin-configs/
kafka_version: 4.2
source_path: content/en/42/generated/admin_client_config.html
---

# Admin client configs (Apache Kafka 4.2)

One `## <entry>` block per item. Search with grep (case-insensitive, ~10 context lines); do not read whole.

## bootstrap.controllers

A list of host/port pairs to use for establishing the initial connection to the KRaft controller quorum. This list should be in the form `host1:port1,host2:port2,...`.

- **Type:** list
- **Default:** ""
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_bootstrap.controllers

## bootstrap.servers

A list of host/port pairs used to establish the initial connection to the Kafka cluster. Clients use this list to bootstrap and discover the full set of Kafka brokers. While the order of servers in the list does not matter, we recommend including more than one server to ensure resilience if any servers are down. This list does not need to contain the entire set of brokers, as Kafka clients automatically manage and update connections to the cluster efficiently. This list must be in the form `host1:port1,host2:port2,...`.

- **Type:** list
- **Default:** ""
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_bootstrap.servers

## sasl.oauthbearer.expected.audience

The (strongly recommended) comma-delimited setting for the broker to use to verify that the JWT was issued for one of the expected audiences. The JWT will be inspected for the standard OAuth "aud" claim and if this value is set, the broker will match the value from JWT's "aud" claim to see if there is an exact match. If there is no match, the broker will reject the JWT and authentication will fail. If this value is not set, the broker will accept a token that has no "aud" claim, which is strongly discouraged.

- **Type:** list
- **Default:** ""
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.expected.audience

## sasl.oauthbearer.expected.issuer

The (strongly recommended) setting for the broker to use to verify that the JWT was created by the expected issuer. The JWT will be inspected for the standard OAuth "iss" claim and if this value is set, the broker will match it exactly against what is in the JWT's "iss" claim. If there is no match, the broker will reject the JWT and authentication will fail. If this value is not set, the broker will accept a JWT bearing any (or no) issuer, which is strongly discouraged.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.expected.issuer

## ssl.key.password

The password of the private key in the key store file or the PEM key specified in 'ssl.keystore.key'.

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.key.password

## ssl.keystore.certificate.chain

Certificate chain in the format specified by 'ssl.keystore.type'. Default SSL engine factory supports only PEM format with a list of X.509 certificates

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.keystore.certificate.chain

## ssl.keystore.key

Private key in the format specified by 'ssl.keystore.type'. Default SSL engine factory supports only PEM format with PKCS#8 keys. If the key is encrypted, key password must be specified using 'ssl.key.password'

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.keystore.key

## ssl.keystore.location

The location of the key store file. This is optional for client and can be used for two-way authentication for client.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.keystore.location

## ssl.keystore.password

The store password for the key store file. This is optional for client and only needed if 'ssl.keystore.location' is configured. Key store password is not supported for PEM format.

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.keystore.password

## ssl.truststore.certificates

Trusted certificates in the format specified by 'ssl.truststore.type'. Default SSL engine factory supports only PEM format with X.509 certificates.

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.truststore.certificates

## ssl.truststore.location

The location of the trust store file.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.truststore.location

## ssl.truststore.password

The password for the trust store file. If a password is not set, trust store file configured will still be used, but integrity checking is disabled. Trust store password is not supported for PEM format.

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** high
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.truststore.password

## client.dns.lookup

Controls how the client uses DNS lookups. If set to `use_all_dns_ips`, connect to each returned IP address in sequence until a successful connection is established. After a disconnection, the next IP is used. Once all IPs have been used once, the client resolves the IP(s) from the hostname again (both the JVM and the OS cache DNS name lookups, however). If set to `resolve_canonical_bootstrap_servers_only`, resolve each bootstrap address into a list of canonical names. After the bootstrap phase, this behaves the same as `use_all_dns_ips`.

- **Type:** string
- **Default:** use_all_dns_ips
- **Valid Values:** [use_all_dns_ips, resolve_canonical_bootstrap_servers_only]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_client.dns.lookup

## client.id

An id string to pass to the server when making requests. The purpose of this is to be able to track the source of requests beyond just ip/port by allowing a logical application name to be included in server-side request logging.

- **Type:** string
- **Default:** ""
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_client.id

## connections.max.idle.ms

Close idle connections after the number of milliseconds specified by this config.

- **Type:** long
- **Default:** 300000 (5 minutes)
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_connections.max.idle.ms

## default.api.timeout.ms

Specifies the timeout (in milliseconds) for client APIs. This configuration is used as the default timeout for all client operations that do not specify a `timeout` parameter.

- **Type:** int
- **Default:** 60000 (1 minute)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_default.api.timeout.ms

## receive.buffer.bytes

The size of the TCP receive buffer (SO_RCVBUF) to use when reading data. If the value is -1, the OS default will be used.

- **Type:** int
- **Default:** 65536 (64 kibibytes)
- **Valid Values:** [-1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_receive.buffer.bytes

## request.timeout.ms

The configuration controls the maximum amount of time the client will wait for the response of a request. If the response is not received before the timeout elapses the client will resend the request if necessary or fail the request if retries are exhausted.

- **Type:** int
- **Default:** 30000 (30 seconds)
- **Valid Values:** [0,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_request.timeout.ms

## sasl.client.callback.handler.class

The fully qualified name of a SASL client callback handler class that implements the AuthenticateCallbackHandler interface.

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.client.callback.handler.class

## sasl.jaas.config

JAAS login context parameters for SASL connections in the format used by JAAS configuration files. JAAS configuration file format is described here. The format for the value is: `loginModuleClass controlFlag (optionName=optionValue)*;`. For brokers, the config must be prefixed with listener prefix and SASL mechanism name in lower-case. For example, listener.name.sasl_ssl.scram-sha-256.sasl.jaas.config=com.example.ScramLoginModule required;

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.jaas.config

## sasl.kerberos.service.name

The Kerberos principal name that Kafka runs as. This can be defined either in Kafka's JAAS config or in Kafka's config.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.kerberos.service.name

## sasl.login.callback.handler.class

The fully qualified name of a SASL login callback handler class that implements the AuthenticateCallbackHandler interface. For brokers, login callback handler config must be prefixed with listener prefix and SASL mechanism name in lower-case. For example, listener.name.sasl_ssl.scram-sha-256.sasl.login.callback.handler.class=com.example.CustomScramLoginCallbackHandler

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.login.callback.handler.class

## sasl.login.class

The fully qualified name of a class that implements the Login interface. For brokers, login config must be prefixed with listener prefix and SASL mechanism name in lower-case. For example, listener.name.sasl_ssl.scram-sha-256.sasl.login.class=com.example.CustomScramLogin

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.login.class

## sasl.mechanism

SASL mechanism used for client connections. This may be any mechanism for which a security provider is available. GSSAPI is the default mechanism.

- **Type:** string
- **Default:** GSSAPI
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.mechanism

## sasl.oauthbearer.assertion.algorithm

The algorithm the Apache Kafka client should use to sign the assertion sent to the identity provider. It is also used as the value of the OAuth `alg` (Algorithm) header in the JWT assertion.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** RS256
- **Valid Values:** (case insensitive) [ES256, RS256]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.assertion.algorithm

## sasl.oauthbearer.assertion.claim.aud

The JWT `aud` (Audience) claim which will be included in the client JWT assertion created locally.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.assertion.claim.aud

## sasl.oauthbearer.assertion.claim.iss

The value to be used as the `iss` (Issuer) claim which will be included in the client JWT assertion created locally.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.assertion.claim.iss

## sasl.oauthbearer.assertion.claim.jti.include

Flag that determines if the JWT assertion should generate a unique ID for the JWT and include it in the `jti` (JWT ID) claim.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.assertion.claim.jti.include

## sasl.oauthbearer.assertion.claim.sub

The value to be used as the `sub` (Subject) claim which will be included in the client JWT assertion created locally.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.assertion.claim.sub

## sasl.oauthbearer.assertion.file



- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.assertion.file

## sasl.oauthbearer.assertion.private.key.file

File that contains a private key in the standard PEM format which is used to sign the JWT assertion sent to the identity provider.

The underlying implementation caches the file contents to avoid the performance hit of loading the file on each access. The caching mechanism will detect when the file changes to allow for the file to be reloaded on modifications. This allows for "live" private key rotation without restarting the Kafka client.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.assertion.private.key.file

## sasl.oauthbearer.assertion.private.key.passphrase

The optional passphrase to decrypt the private key file specified by `sasl.oauthbearer.assertion.private.key.file`.

Note: If the file referred to by `sasl.oauthbearer.assertion.private.key.file` is modified on the file system at runtime and it was created with a different passphrase than it was previously, the client will not be able to access the private key file because the passphrase is now out of date. For that reason, when using private key passphrases, either use the same passphrase each time, or—for improved security—restart the Kafka client using the new passphrase configuration.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** password
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.assertion.private.key.passphrase

## sasl.oauthbearer.assertion.template.file

This optional configuration specifies the file containing the JWT headers and/or payload claims to be used when creating the JWT assertion.

Not all identity providers require the same set of claims; some may require a given claim while others may prohibit it. In order to provide the most flexibility, this configuration allows the user to provide the static header values and claims that are to be included in the JWT.

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.assertion.template.file

## sasl.oauthbearer.client.credentials.client.id



- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.client.credentials.client.id

## sasl.oauthbearer.client.credentials.client.secret



- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.client.credentials.client.secret

## sasl.oauthbearer.jwks.endpoint.url

The OAuth/OIDC provider URL from which the provider's JWKS (JSON Web Key Set) can be retrieved. The URL can be HTTP(S)-based or file-based. If the URL is HTTP(S)-based, the JWKS data will be retrieved from the OAuth/OIDC provider via the configured URL on broker startup. All then-current keys will be cached on the broker for incoming requests. If an authentication request is received for a JWT that includes a "kid" header claim value that isn't yet in the cache, the JWKS endpoint will be queried again on demand. However, the broker polls the URL every sasl.oauthbearer.jwks.endpoint.refresh.ms milliseconds to refresh the cache with any forthcoming keys before any JWT requests that include them are received. If the URL is file-based, the broker will load the JWKS file from a configured location on startup. In the event that the JWT includes a "kid" header value that isn't in the JWKS file, the broker will reject the JWT and authentication will fail.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.jwks.endpoint.url

## sasl.oauthbearer.jwt.retriever.class



- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.jwt.retriever.class

## sasl.oauthbearer.jwt.validator.class



- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.jwt.validator.class

## sasl.oauthbearer.scope



- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.scope

## sasl.oauthbearer.token.endpoint.url

The URL for the OAuth/OIDC identity provider. If the URL is HTTP(S)-based, it is the issuer's token endpoint URL to which requests will be made to login based on the configuration in `sasl.oauthbearer.jwt.retriever.class`. If the URL is file-based, it specifies a file containing an access token (in JWT serialized form) issued by the OAuth/OIDC identity provider to use for authorization.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.token.endpoint.url

## security.protocol

Protocol used to communicate with brokers.

- **Type:** string
- **Default:** PLAINTEXT
- **Valid Values:** (case insensitive) [SASL_SSL, PLAINTEXT, SSL, SASL_PLAINTEXT]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_security.protocol

## send.buffer.bytes

The size of the TCP send buffer (SO_SNDBUF) to use when sending data. If the value is -1, the OS default will be used.

- **Type:** int
- **Default:** 131072 (128 kibibytes)
- **Valid Values:** [-1,...]
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_send.buffer.bytes

## socket.connection.setup.timeout.max.ms

The maximum amount of time the client will wait for the socket connection to be established. The connection setup timeout will increase exponentially for each consecutive connection failure up to this maximum. To avoid connection storms, a randomization factor of 0.2 will be applied to the timeout resulting in a random range between 20% below and 20% above the computed value.

- **Type:** long
- **Default:** 30000 (30 seconds)
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_socket.connection.setup.timeout.max.ms

## socket.connection.setup.timeout.ms

The amount of time the client will wait for the socket connection to be established. If the connection is not built before the timeout elapses, clients will close the socket channel. This value is the initial backoff value and will increase exponentially for each consecutive connection failure, up to the `socket.connection.setup.timeout.max.ms` value.

- **Type:** long
- **Default:** 10000 (10 seconds)
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_socket.connection.setup.timeout.ms

## ssl.enabled.protocols

The list of protocols enabled for SSL connections. The default is 'TLSv1.2,TLSv1.3'. This means that clients and servers will prefer TLSv1.3 if both support it and fallback to TLSv1.2 otherwise (assuming both support at least TLSv1.2). This default should be fine for most use cases. If this configuration is set to an empty list, Kafka will use the protocols enabled by default in the underlying SSLEngine, which may include additional protocols depending on the JVM version. Also see the config documentation for `ssl.protocol` to understand how it can impact the TLS version negotiation behavior.

- **Type:** list
- **Default:** TLSv1.2,TLSv1.3
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.enabled.protocols

## ssl.keystore.type

The file format of the key store file. This is optional for client. The values currently supported by the default `ssl.engine.factory.class` are [JKS, PKCS12, PEM].

- **Type:** string
- **Default:** JKS
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.keystore.type

## ssl.protocol

The SSL protocol used to generate the SSLContext. The default is 'TLSv1.3', which should be fine for most use cases. A typical alternative to the default is 'TLSv1.2'. Allowed values for this config are dependent on the JVM. Clients using the defaults for this config and 'ssl.enabled.protocols' will downgrade to 'TLSv1.2' if the server does not support 'TLSv1.3'. If this config is set to 'TLSv1.2', however, clients will not use 'TLSv1.3' even if it is one of the values in `ssl.enabled.protocols` and the server only supports 'TLSv1.3'.

- **Type:** string
- **Default:** TLSv1.3
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.protocol

## ssl.provider

The name of the security provider used for SSL connections. Default value is the default security provider of the JVM.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.provider

## ssl.truststore.type

The file format of the trust store file. The values currently supported by the default `ssl.engine.factory.class` are [JKS, PKCS12, PEM].

- **Type:** string
- **Default:** JKS
- **Valid Values:** (empty)
- **Importance:** medium
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.truststore.type

## config.providers

Comma-separated alias names for classes implementing the `ConfigProvider` interface. This enables loading configuration data (such as passwords, API keys, and other credentials) from external sources. For example, see Configuration Providers.

- **Type:** list
- **Default:** ""
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_config.providers

## enable.metrics.push

Whether to enable pushing of client metrics to the cluster, if the cluster has a client metrics subscription which matches this client.

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_enable.metrics.push

## metadata.max.age.ms

The period of time in milliseconds after which we force a refresh of metadata even if we haven't seen any partition leadership changes to proactively discover any new brokers or partitions.

- **Type:** long
- **Default:** 300000 (5 minutes)
- **Valid Values:** [0,...]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_metadata.max.age.ms

## metadata.recovery.rebootstrap.trigger.ms

If a client configured to rebootstrap using `metadata.recovery.strategy=rebootstrap` is unable to obtain metadata from any of the brokers in the last known metadata for this interval, client repeats the bootstrap process using `bootstrap.servers` configuration.

- **Type:** long
- **Default:** 300000 (5 minutes)
- **Valid Values:** [0,...]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_metadata.recovery.rebootstrap.trigger.ms

## metadata.recovery.strategy

Controls how the client recovers when none of the brokers known to it is available. If set to `none`, the client fails. If set to `rebootstrap`, the client repeats the bootstrap process using `bootstrap.servers`. Rebootstrapping is useful when a client communicates with brokers so infrequently that the set of brokers may change entirely before the client refreshes metadata. Metadata recovery is triggered when all last-known brokers appear unavailable simultaneously. Brokers appear unavailable when disconnected and no current retry attempt is in-progress. Consider increasing `reconnect.backoff.ms` and `reconnect.backoff.max.ms` and decreasing `socket.connection.setup.timeout.ms` and `socket.connection.setup.timeout.max.ms` for the client. Rebootstrap is also triggered if connection cannot be established to any of the brokers for `metadata.recovery.rebootstrap.trigger.ms` milliseconds or if server requests rebootstrap.

- **Type:** string
- **Default:** rebootstrap
- **Valid Values:** (case insensitive) [REBOOTSTRAP, NONE]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_metadata.recovery.strategy

## metric.reporters

A list of classes to use as metrics reporters. Implementing the `org.apache.kafka.common.metrics.MetricsReporter` interface allows plugging in classes that will be notified of new metric creation. When custom reporters are set and `org.apache.kafka.common.metrics.JmxReporter` is needed, it has to be explicitly added to the list.

- **Type:** list
- **Default:** org.apache.kafka.common.metrics.JmxReporter
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_metric.reporters

## metrics.num.samples

The number of samples maintained to compute metrics.

- **Type:** int
- **Default:** 2
- **Valid Values:** [1,...]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_metrics.num.samples

## metrics.recording.level

The highest recording level for metrics. It has three levels for recording metrics - info, debug, and trace.

INFO level records only essential metrics necessary for monitoring system performance and health. It collects vital data without gathering too much detail, making it suitable for production environments where minimal overhead is desired.

DEBUG level records most metrics, providing more detailed information about the system's operation. It's useful for development and testing environments where you need deeper insights to debug and fine-tune the application.

TRACE level records all possible metrics, capturing every detail about the system's performance and operation. It's best for controlled environments where in-depth analysis is required, though it can introduce significant overhead.

- **Type:** string
- **Default:** INFO
- **Valid Values:** [INFO, DEBUG, TRACE]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_metrics.recording.level

## metrics.sample.window.ms

The window of time a metrics sample is computed over.

- **Type:** long
- **Default:** 30000 (30 seconds)
- **Valid Values:** [0,...]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_metrics.sample.window.ms

## reconnect.backoff.max.ms

The maximum amount of time in milliseconds to wait when reconnecting to a broker that has repeatedly failed to connect. If provided, the backoff per host will increase exponentially for each consecutive connection failure, up to this maximum. After calculating the backoff increase, 20% random jitter is added to avoid connection storms.

- **Type:** long
- **Default:** 1000 (1 second)
- **Valid Values:** [0,...]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_reconnect.backoff.max.ms

## reconnect.backoff.ms

The base amount of time to wait before attempting to reconnect to a given host. This avoids repeatedly connecting to a host in a tight loop. This backoff applies to all connection attempts by the client to a broker. This value is the initial backoff value and will increase exponentially for each consecutive connection failure, up to the `reconnect.backoff.max.ms` value.

- **Type:** long
- **Default:** 50
- **Valid Values:** [0,...]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_reconnect.backoff.ms

## retries

It is recommended to set the value to either `MAX_VALUE` or zero, and use corresponding timeout parameters to control how long a client should retry a request. Setting a value greater than zero will cause the client to resend any request that fails with a potentially transient error. Setting a value of zero will lead to transient errors not being retried, and they will be propagated to the application to be handled.

- **Type:** int
- **Default:** 2147483647
- **Valid Values:** [0,...,2147483647]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_retries

## retry.backoff.max.ms

The maximum amount of time in milliseconds to wait when retrying a request to the broker that has repeatedly failed. If provided, the backoff per client will increase exponentially for each failed request, up to this maximum. To prevent all clients from being synchronized upon retry, a randomized jitter with a factor of 0.2 will be applied to the backoff, resulting in the backoff falling within a range between 20% below and 20% above the computed value. If `retry.backoff.ms` is set to be higher than `retry.backoff.max.ms`, then `retry.backoff.max.ms` will be used as a constant backoff from the beginning without any exponential increase

- **Type:** long
- **Default:** 1000 (1 second)
- **Valid Values:** [0,...]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_retry.backoff.max.ms

## retry.backoff.ms

The amount of time to wait before attempting to retry a failed request to a given topic partition. This avoids repeatedly sending requests in a tight loop under some failure scenarios. This value is the initial backoff value and will increase exponentially for each failed request, up to the `retry.backoff.max.ms` value.

- **Type:** long
- **Default:** 100
- **Valid Values:** [0,...]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_retry.backoff.ms

## sasl.kerberos.kinit.cmd

Kerberos kinit command path.

- **Type:** string
- **Default:** /usr/bin/kinit
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.kerberos.kinit.cmd

## sasl.kerberos.min.time.before.relogin

Login thread sleep time between refresh attempts.

- **Type:** long
- **Default:** 60000
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.kerberos.min.time.before.relogin

## sasl.kerberos.ticket.renew.jitter

Percentage of random jitter added to the renewal time.

- **Type:** double
- **Default:** 0.05
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.kerberos.ticket.renew.jitter

## sasl.kerberos.ticket.renew.window.factor

Login thread will sleep until the specified window factor of time from last refresh to ticket's expiry has been reached, at which time it will try to renew the ticket.

- **Type:** double
- **Default:** 0.8
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.kerberos.ticket.renew.window.factor

## sasl.login.connect.timeout.ms

The (optional) value in milliseconds for the external authentication provider connection timeout. Currently applies only to OAUTHBEARER.

- **Type:** int
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.login.connect.timeout.ms

## sasl.login.read.timeout.ms

The (optional) value in milliseconds for the external authentication provider read timeout. Currently applies only to OAUTHBEARER.

- **Type:** int
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.login.read.timeout.ms

## sasl.login.refresh.buffer.seconds

The amount of buffer time before credential expiration to maintain when refreshing a credential, in seconds. If a refresh would otherwise occur closer to expiration than the number of buffer seconds then the refresh will be moved up to maintain as much of the buffer time as possible. Legal values are between 0 and 3600 (1 hour); a default value of 300 (5 minutes) is used if no value is specified. This value and sasl.login.refresh.min.period.seconds are both ignored if their sum exceeds the remaining lifetime of a credential. Currently applies only to OAUTHBEARER.

- **Type:** short
- **Default:** 300
- **Valid Values:** [0,...,3600]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.login.refresh.buffer.seconds

## sasl.login.refresh.min.period.seconds

The desired minimum time for the login refresh thread to wait before refreshing a credential, in seconds. Legal values are between 0 and 900 (15 minutes); a default value of 60 (1 minute) is used if no value is specified. This value and sasl.login.refresh.buffer.seconds are both ignored if their sum exceeds the remaining lifetime of a credential. Currently applies only to OAUTHBEARER.

- **Type:** short
- **Default:** 60
- **Valid Values:** [0,...,900]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.login.refresh.min.period.seconds

## sasl.login.refresh.window.factor

Login refresh thread will sleep until the specified window factor relative to the credential's lifetime has been reached, at which time it will try to refresh the credential. Legal values are between 0.5 (50%) and 1.0 (100%) inclusive; a default value of 0.8 (80%) is used if no value is specified. Currently applies only to OAUTHBEARER.

- **Type:** double
- **Default:** 0.8
- **Valid Values:** [0.5,...,1.0]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.login.refresh.window.factor

## sasl.login.refresh.window.jitter

The maximum amount of random jitter relative to the credential's lifetime that is added to the login refresh thread's sleep time. Legal values are between 0 and 0.25 (25%) inclusive; a default value of 0.05 (5%) is used if no value is specified. Currently applies only to OAUTHBEARER.

- **Type:** double
- **Default:** 0.05
- **Valid Values:** [0.0,...,0.25]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.login.refresh.window.jitter

## sasl.login.retry.backoff.max.ms

The (optional) value in milliseconds for the maximum wait between login attempts to the external authentication provider. Login uses an exponential backoff algorithm with an initial wait based on the sasl.login.retry.backoff.ms setting and will double in wait length between attempts up to a maximum wait length specified by the sasl.login.retry.backoff.max.ms setting. Currently applies only to OAUTHBEARER.

- **Type:** long
- **Default:** 10000 (10 seconds)
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.login.retry.backoff.max.ms

## sasl.login.retry.backoff.ms

The (optional) value in milliseconds for the initial wait between login attempts to the external authentication provider. Login uses an exponential backoff algorithm with an initial wait based on the sasl.login.retry.backoff.ms setting and will double in wait length between attempts up to a maximum wait length specified by the sasl.login.retry.backoff.max.ms setting. Currently applies only to OAUTHBEARER.

- **Type:** long
- **Default:** 100
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.login.retry.backoff.ms

## sasl.oauthbearer.assertion.claim.exp.seconds

The number of seconds in the future for which the JWT is valid. The value is used to determine the JWT `exp` (Expiration) claim based on the current system time when the JWT is created.

The formula to generate the `exp` claim is very simple:Let:

x = the current timestamp in seconds, on client
y = the value of this configuration

Then:

exp = x + y

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** int
- **Default:** 300
- **Valid Values:** [0,...,86400]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.assertion.claim.exp.seconds

## sasl.oauthbearer.assertion.claim.nbf.seconds

The number of seconds in the past from which the JWT is valid. The value is used to determine the JWT `nbf` (Not Before) claim based on the current system time when the JWT is created.

The formula to generate the `nbf` claim is very simple:Let:

x = the current timestamp in seconds, on client
y = the value of this configuration

Then:

nbf = x - y

Note: If a value for `sasl.oauthbearer.assertion.file` is provided, this configuration will be ignored.

- **Type:** int
- **Default:** 60
- **Valid Values:** [0,...,3600]
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.assertion.claim.nbf.seconds

## sasl.oauthbearer.clock.skew.seconds

The (optional) value in seconds to allow for differences between the time of the OAuth/OIDC identity provider and the broker.

- **Type:** int
- **Default:** 30
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.clock.skew.seconds

## sasl.oauthbearer.header.urlencode

The (optional) setting to enable the OAuth client to URL-encode the client_id and client_secret in the authorization header in accordance with RFC6749, see here for more details. The default value is set to 'false' for backward compatibility

- **Type:** boolean
- **Default:** false
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.header.urlencode

## sasl.oauthbearer.jwks.endpoint.refresh.ms

The (optional) value in milliseconds for the broker to wait between refreshing its JWKS (JSON Web Key Set) cache that contains the keys to verify the signature of the JWT.

- **Type:** long
- **Default:** 3600000 (1 hour)
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.jwks.endpoint.refresh.ms

## sasl.oauthbearer.jwks.endpoint.retry.backoff.max.ms

The (optional) value in milliseconds for the maximum wait between attempts to retrieve the JWKS (JSON Web Key Set) from the external authentication provider. JWKS retrieval uses an exponential backoff algorithm with an initial wait based on the sasl.oauthbearer.jwks.endpoint.retry.backoff.ms setting and will double in wait length between attempts up to a maximum wait length specified by the sasl.oauthbearer.jwks.endpoint.retry.backoff.max.ms setting.

- **Type:** long
- **Default:** 10000 (10 seconds)
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.jwks.endpoint.retry.backoff.max.ms

## sasl.oauthbearer.jwks.endpoint.retry.backoff.ms

The (optional) value in milliseconds for the initial wait between JWKS (JSON Web Key Set) retrieval attempts from the external authentication provider. JWKS retrieval uses an exponential backoff algorithm with an initial wait based on the sasl.oauthbearer.jwks.endpoint.retry.backoff.ms setting and will double in wait length between attempts up to a maximum wait length specified by the sasl.oauthbearer.jwks.endpoint.retry.backoff.max.ms setting.

- **Type:** long
- **Default:** 100
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.jwks.endpoint.retry.backoff.ms

## sasl.oauthbearer.scope.claim.name

The OAuth claim for the scope is often named "scope", but this (optional) setting can provide a different name to use for the scope included in the JWT payload's claims if the OAuth/OIDC provider uses a different name for that claim.

- **Type:** string
- **Default:** scope
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.scope.claim.name

## sasl.oauthbearer.sub.claim.name

The OAuth claim for the subject is often named "sub", but this (optional) setting can provide a different name to use for the subject included in the JWT payload's claims if the OAuth/OIDC provider uses a different name for that claim.

- **Type:** string
- **Default:** sub
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_sasl.oauthbearer.sub.claim.name

## security.providers

A list of configurable creator classes each returning a provider implementing security algorithms. These classes should implement the `org.apache.kafka.common.security.auth.SecurityProviderCreator` interface.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_security.providers

## ssl.cipher.suites

A list of cipher suites. This is a named combination of authentication, encryption, MAC and key exchange algorithm used to negotiate the security settings for a network connection using TLS or SSL network protocol. By default all the available cipher suites are supported.

- **Type:** list
- **Default:** ""
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.cipher.suites

## ssl.endpoint.identification.algorithm

The endpoint identification algorithm to validate server hostname using server certificate.

- **Type:** string
- **Default:** https
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.endpoint.identification.algorithm

## ssl.engine.factory.class

The class of type org.apache.kafka.common.security.auth.SslEngineFactory to provide SSLEngine objects. Default value is org.apache.kafka.common.security.ssl.DefaultSslEngineFactory. Alternatively, setting this to org.apache.kafka.common.security.ssl.CommonNameLoggingSslEngineFactory will log the common name of expired SSL certificates used by clients to authenticate at any of the brokers with log level INFO. Note that this will cause a tiny delay during establishment of new connections from mTLS clients to brokers due to the extra code for examining the certificate chain provided by the client. Note further that the implementation uses a custom truststore based on the standard Java truststore and thus might be considered a security risk due to not being as mature as the standard one.

- **Type:** class
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.engine.factory.class

## ssl.keymanager.algorithm

The algorithm used by key manager factory for SSL connections. Default value is the key manager factory algorithm configured for the Java Virtual Machine.

- **Type:** string
- **Default:** SunX509
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.keymanager.algorithm

## ssl.secure.random.implementation

The SecureRandom PRNG implementation to use for SSL cryptography operations.

- **Type:** string
- **Default:** null
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.secure.random.implementation

## ssl.trustmanager.algorithm

The algorithm used by trust manager factory for SSL connections. Default value is the trust manager factory algorithm configured for the Java Virtual Machine.

- **Type:** string
- **Default:** PKIX
- **Valid Values:** (empty)
- **Importance:** low
- **Docs:** https://kafka.apache.org/42/configuration/admin-configs/#adminclientconfigs_ssl.trustmanager.algorithm
