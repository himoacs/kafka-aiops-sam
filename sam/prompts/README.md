# Starter prompts

Thirteen prompts for SAM's prompt library. Load them with:

```bash
sam/prompts/import-prompts.sh http://<your SAM URL>      # idempotent; updates changed prompts in place
```

- Topic and group names in them (`orders.order.created`, `payments.payment.settled`) are **examples**. Edit the
  `promptText` in the JSON files to names from your cluster before importing, or edit them in SAM afterwards.
- `/request-access`, `/sample-java`, `/topic-owner` and `/escalate-p1` draw on the **example** institutional
  knowledge skill (`sam/skills/acme-kafka-knowledge`). They only give useful answers once you have replaced that
  content with your own ([../../docs/customize-knowledge.md](../../docs/customize-knowledge.md)).
- `/producer-timeouts` quotes the librdkafka client error `Local: Message timed out` (`_MSG_TIMED_OUT`). A Java
  producer reports the same situation as a `TimeoutException` ("Expiring N record(s) ... ms has passed since
  batch creation").
