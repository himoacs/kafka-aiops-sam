# Acme Global Bank - Java Kafka Client Standards and Reference Sample

> **Fictional example data.** The sample code is real: it compiled and ran against an Apache Kafka 4.2.2 test cluster with SASL_SSL and SCRAM. The credentials and CA path are placeholders you receive during onboarding (`app-onboarding.md`).

## Acme standards for Java applications

| Area | Standard |
|---|---|
| Library | Official `org.apache.kafka:kafka-clients` **4.2.x**, Java 17+ |
| Connection | `bootstrap.servers=kafka-1:9092,kafka-2:9092,kafka-3:9092`, `security.protocol=SASL_SSL`, `sasl.mechanism=SCRAM-SHA-512`, trust the ESP CA via `ssl.truststore.type=PEM` + `ssl.truststore.location`. Never disable verification. |
| Credentials | From environment/vault at runtime (`KAFKA_USER`, `KAFKA_PASSWORD`). Never in source, images or logs. |
| Producer durability | `acks=all`, `enable.idempotence=true` (cluster has `min.insync.replicas=2`; `acks=1` is prohibited for Tier 1 data) |
| Producer behaviour | `compression.type=lz4`, `linger.ms=20`, `delivery.timeout.ms=60000`, `request.timeout.ms=15000`; always handle the send callback; `flush()` before exit; key by a business id that spreads load (a skewed key creates a hot partition) |
| Consumer commits | `enable.auto.commit=false`; process then `commitSync()` (at-least-once); handlers must be idempotent |
| Consumer behaviour | `max.poll.records=100`, `max.poll.interval.ms=300000` (processing a batch must finish within it, or the consumer is kicked out and the group rebalances), `auto.offset.reset=earliest` (use `none` on PCI-scope topics so a lost offset fails loudly) |
| Failures | Retry a bad record 3 times, then publish it to `<topic>.dlq` with the error in a header and continue. Never block a partition on one poison record. |
| Shutdown | `wakeup()` + `close()` in a shutdown hook so the group rebalances promptly |
| Observability | Log `client.id`, group, topic and partition on errors; never log payloads of PCI/personal data |

## Reference sample (Maven)

`pom.xml` essentials:

```xml
<dependencies>
  <dependency>
    <groupId>org.apache.kafka</groupId>
    <artifactId>kafka-clients</artifactId>
    <version>4.2.2</version>
  </dependency>
  <dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-simple</artifactId>
    <version>2.0.16</version>
  </dependency>
</dependencies>
<properties><maven.compiler.release>17</maven.compiler.release></properties>
```

`KafkaCommon.java` (shared connection settings):

```java
package com.acmebank.esp.sample;

import java.util.Properties;

final class KafkaCommon {
    static String env(String key, String dflt) {
        String v = System.getenv(key);
        return (v == null || v.isBlank()) ? dflt : v;
    }

    /** Connection + security settings required by Acme standards. */
    static Properties base(String clientId) {
        String user = env("KAFKA_USER", null), pass = env("KAFKA_PASSWORD", null);
        if (user == null || pass == null) throw new IllegalStateException("KAFKA_USER and KAFKA_PASSWORD must be set");
        Properties p = new Properties();
        p.put("bootstrap.servers", env("KAFKA_BOOTSTRAP", "kafka-1:9092,kafka-2:9092,kafka-3:9092"));
        p.put("client.id", clientId);
        p.put("security.protocol", "SASL_SSL");
        p.put("sasl.mechanism", "SCRAM-SHA-512");
        p.put("sasl.jaas.config", "org.apache.kafka.common.security.scram.ScramLoginModule required "
                + "username=\"" + user + "\" password=\"" + pass + "\";");
        p.put("ssl.truststore.type", "PEM");
        p.put("ssl.truststore.location", env("KAFKA_CA_PEM", "/etc/acme/kafka/ca.pem"));
        return p;
    }
}
```

`OrderProducer.java`:

```java
package com.acmebank.esp.sample;

import java.util.Properties;
import java.util.UUID;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringSerializer;

public class OrderProducer {
    public static void main(String[] args) {
        String topic = KafkaCommon.env("KAFKA_TOPIC", "orders.order.created");
        Properties p = KafkaCommon.base("orders-svc-1");
        p.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        p.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        p.put(ProducerConfig.ACKS_CONFIG, "all");                       // wait for all in-sync replicas
        p.put(ProducerConfig.ENABLE_IDEMPOTENCE_CONFIG, "true");        // no duplicates on retry
        p.put(ProducerConfig.COMPRESSION_TYPE_CONFIG, "lz4");
        p.put(ProducerConfig.LINGER_MS_CONFIG, "20");
        p.put(ProducerConfig.DELIVERY_TIMEOUT_MS_CONFIG, "60000");
        p.put(ProducerConfig.REQUEST_TIMEOUT_MS_CONFIG, "15000");

        try (KafkaProducer<String, String> producer = new KafkaProducer<>(p)) {
            for (int i = 0; i < 10; i++) {
                String key = "cust-" + (i % 5);                          // business key spreads load across partitions
                String value = "{\"orderId\":\"" + UUID.randomUUID() + "\",\"amount\":" + (10 + i) + "}";
                producer.send(new ProducerRecord<>(topic, key, value), (meta, ex) -> {
                    if (ex != null) {
                        System.err.println("send failed: " + ex);       // alert on this in real apps
                    } else {
                        System.out.printf("sent %s-%d@%d%n", meta.topic(), meta.partition(), meta.offset());
                    }
                });
            }
            producer.flush();                                            // do not exit with records still buffered
        }
    }
}
```

`OrderConsumer.java`:

```java
package com.acmebank.esp.sample;

import java.time.Duration;
import java.util.List;
import java.util.Properties;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.errors.WakeupException;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.apache.kafka.common.serialization.StringSerializer;

public class OrderConsumer {
    public static void main(String[] args) {
        String topic = KafkaCommon.env("KAFKA_TOPIC", "orders.order.created");
        String group = KafkaCommon.env("KAFKA_GROUP", "myapp-consumer");   // <app>-consumer
        Properties c = KafkaCommon.base("myapp-svc-1");
        c.put(ConsumerConfig.GROUP_ID_CONFIG, group);
        c.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        c.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        c.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, "false");           // commit only after processing
        c.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        c.put(ConsumerConfig.MAX_POLL_RECORDS_CONFIG, "100");
        c.put(ConsumerConfig.MAX_POLL_INTERVAL_MS_CONFIG, "300000");        // a batch must finish within this

        Properties d = KafkaCommon.base("myapp-dlq-1");                     // DLQ producer (needs Write on <topic>.dlq)
        d.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        d.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        d.put(ProducerConfig.ACKS_CONFIG, "all");

        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(c);
        KafkaProducer<String, String> dlq = new KafkaProducer<>(d);
        Thread main = Thread.currentThread();
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {             // clean exit so the group rebalances quickly
            consumer.wakeup();
            try { main.join(10_000); } catch (InterruptedException ignored) { }
        }));

        try {
            consumer.subscribe(List.of(topic));
            int max = Integer.parseInt(KafkaCommon.env("MAX_MESSAGES", "-1")), seen = 0;
            while (max < 0 || seen < max) {
                ConsumerRecords<String, String> records = consumer.poll(Duration.ofSeconds(1));
                for (ConsumerRecord<String, String> r : records) {
                    handleWithRetry(r, dlq, topic + ".dlq");
                    seen++;
                }
                if (!records.isEmpty()) consumer.commitSync();              // at-least-once
            }
        } catch (WakeupException expected) {
            // shutting down
        } finally {
            consumer.close();
            dlq.close();
        }
    }

    static void handleWithRetry(ConsumerRecord<String, String> r, KafkaProducer<String, String> dlq, String dlqTopic) {
        for (int attempt = 1; attempt <= 3; attempt++) {
            try {
                process(r);                                                  // must be idempotent
                return;
            } catch (Exception e) {
                System.err.printf("attempt %d failed for %s-%d@%d: %s%n", attempt, r.topic(), r.partition(), r.offset(), e);
            }
        }
        dlq.send(new ProducerRecord<>(dlqTopic, r.key(), r.value()));        // park the poison record, keep going
    }

    static void process(ConsumerRecord<String, String> r) {
        System.out.printf("got %s-%d@%d key=%s%n", r.topic(), r.partition(), r.offset(), r.key());
    }
}
```

Run (credentials come from onboarding, via the vault):

```bash
export KAFKA_USER=myapp-svc KAFKA_PASSWORD=...        # from kv/esp/myapp
export KAFKA_CA_PEM=/etc/acme/kafka/ca.pem
mvn -q compile exec:java -Dexec.mainClass=com.acmebank.esp.sample.OrderProducer
```

## Spring Boot (spring-kafka) equivalents

> **Not tested.** Unlike the plain Java sample above (compiled and run against KAFKA-PRD-01), this Spring mapping is guidance written from the Spring Kafka property names and has not been run against the cluster. Say so when you share it, and check property names against the Spring Boot version in use.

Use the same properties under `spring.kafka.*` (`bootstrap-servers`, `security.protocol`, `properties.sasl.mechanism`, `properties.sasl.jaas.config`, `ssl.trust-store-type=PEM`), `spring.kafka.producer.acks=all`, `spring.kafka.producer.properties.enable.idempotence=true`, and `spring.kafka.listener.ack-mode=manual` / `enable-auto-commit=false`. Configure a `DefaultErrorHandler` with a `DeadLetterPublishingRecoverer` for `<topic>.dlq`. The Acme standards table applies unchanged.

## Common errors and what they mean here

| Client exception / symptom | Usual cause at Acme | First step |
|---|---|---|
| `TopicAuthorizationException: Not authorized to access topics: [x]` | The principal has no ACL on that topic for that operation (read vs write) | Check the ownership register for who approves; raise an ESP-ACCESS request. Do not ask for wider ACLs than needed. |
| `GroupAuthorizationException` | The consumer `group.id` does not match the group the ACL was granted for | Use the approved group name (`<app>-consumer`) |
| `SaslAuthenticationException` / "Authentication failed" | Wrong or rotated SCRAM password, or wrong principal | Re-fetch credentials from the vault; ESP can reset the credential |
| `SSLHandshakeException` / PKIX path failed | Client does not trust the ESP CA, or hostname mismatch | Install `ca.pem` from `kv/esp/ca.pem`; use the real broker host names; never disable verification |
| `TimeoutException: Failed to update metadata` / `Local: Message timed out` on send | Brokers unreachable, or partitions below `min.insync.replicas` (producer with `acks=all`) | Check cluster health with the AIOps assistant; if under-min-ISR, it is a platform incident (P2+) |
| `CommitFailedException` / `RebalanceInProgressException` / consumer repeatedly kicked out | Processing took longer than `max.poll.interval.ms`, or members flapping | Reduce `max.poll.records` or speed up processing; check for crash loops |
| `RecordTooLargeException` | Record over the 1 MB limit | Store the payload elsewhere and publish a reference |
