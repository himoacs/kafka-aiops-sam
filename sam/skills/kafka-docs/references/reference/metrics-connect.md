---
title: Kafka Connect metrics
source_url: https://kafka.apache.org/42/operations/monitoring/
kafka_version: 4.2
source_path: content/en/42/generated/connect_metrics.html
---

# Kafka Connect metrics (Apache Kafka 4.2)

One `## <entry>` block per item. Search with grep (case-insensitive, ~10 context lines); do not read whole.

## connector-count

- **Description:** The number of connectors run in this worker.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-startup-attempts-total

- **Description:** The total number of connector startups that this worker has attempted.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-startup-failure-percentage

- **Description:** The average percentage of this worker's connectors starts that failed.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-startup-failure-total

- **Description:** The total number of connector starts that failed.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-startup-success-percentage

- **Description:** The average percentage of this worker's connectors starts that succeeded.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-startup-success-total

- **Description:** The total number of connector starts that succeeded.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## task-count

- **Description:** The number of tasks run in this worker.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## task-startup-attempts-total

- **Description:** The total number of task startups that this worker has attempted.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## task-startup-failure-percentage

- **Description:** The average percentage of this worker's tasks starts that failed.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## task-startup-failure-total

- **Description:** The total number of task starts that failed.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## task-startup-success-percentage

- **Description:** The average percentage of this worker's tasks starts that succeeded.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## task-startup-success-total

- **Description:** The total number of task starts that succeeded.
- **Mbean name:** kafka.connect:type=connect-worker-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-destroyed-task-count

- **Description:** The number of destroyed tasks of the connector on the worker.
- **Mbean name:** kafka.connect:type=connect-worker-metrics,connector="{connector}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-failed-task-count

- **Description:** The number of failed tasks of the connector on the worker.
- **Mbean name:** kafka.connect:type=connect-worker-metrics,connector="{connector}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-paused-task-count

- **Description:** The number of paused tasks of the connector on the worker.
- **Mbean name:** kafka.connect:type=connect-worker-metrics,connector="{connector}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-restarting-task-count

- **Description:** The number of restarting tasks of the connector on the worker.
- **Mbean name:** kafka.connect:type=connect-worker-metrics,connector="{connector}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-running-task-count

- **Description:** The number of running tasks of the connector on the worker.
- **Mbean name:** kafka.connect:type=connect-worker-metrics,connector="{connector}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-total-task-count

- **Description:** The number of tasks of the connector on the worker.
- **Mbean name:** kafka.connect:type=connect-worker-metrics,connector="{connector}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-unassigned-task-count

- **Description:** The number of unassigned tasks of the connector on the worker.
- **Mbean name:** kafka.connect:type=connect-worker-metrics,connector="{connector}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## completed-rebalances-total

- **Description:** The total number of rebalances completed by this worker.
- **Mbean name:** kafka.connect:type=connect-worker-rebalance-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connect-protocol

- **Description:** The Connect protocol used by this cluster
- **Mbean name:** kafka.connect:type=connect-worker-rebalance-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## epoch

- **Description:** The epoch or generation number of this worker.
- **Mbean name:** kafka.connect:type=connect-worker-rebalance-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## leader-name

- **Description:** The name of the group leader.
- **Mbean name:** kafka.connect:type=connect-worker-rebalance-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## rebalance-avg-time-ms

- **Description:** The average time in milliseconds spent by this worker to rebalance.
- **Mbean name:** kafka.connect:type=connect-worker-rebalance-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## rebalance-max-time-ms

- **Description:** The maximum time in milliseconds spent by this worker to rebalance.
- **Mbean name:** kafka.connect:type=connect-worker-rebalance-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## rebalancing

- **Description:** Whether this worker is currently rebalancing.
- **Mbean name:** kafka.connect:type=connect-worker-rebalance-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## time-since-last-rebalance-ms

- **Description:** The time in milliseconds since this worker completed the most recent rebalance.
- **Mbean name:** kafka.connect:type=connect-worker-rebalance-metrics
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-class

- **Description:** The name of the connector class.
- **Mbean name:** kafka.connect:type=connector-metrics,connector="{connector}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-type

- **Description:** The type of the connector. One of 'source' or 'sink'.
- **Mbean name:** kafka.connect:type=connector-metrics,connector="{connector}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-version

- **Description:** The version of the connector class, as reported by the connector.
- **Mbean name:** kafka.connect:type=connector-metrics,connector="{connector}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## status

- **Description:** The status of the connector. One of 'unassigned', 'running', 'paused', 'stopped', 'failed', or 'restarting'.
- **Mbean name:** kafka.connect:type=connector-metrics,connector="{connector}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## predicate-class

- **Description:** The class name of the predicate class
- **Mbean name:** kafka.connect:type=connector-predicate-metrics,connector="{connector}",task="{task}",predicate="{predicate}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## predicate-version

- **Description:** The version of the predicate class
- **Mbean name:** kafka.connect:type=connector-predicate-metrics,connector="{connector}",task="{task}",predicate="{predicate}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## batch-size-avg

- **Description:** The average number of records in the batches the task has processed so far.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## batch-size-max

- **Description:** The number of records in the largest batch the task has processed so far.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-class

- **Description:** The name of the connector class.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-type

- **Description:** The type of the connector. One of 'source' or 'sink'.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## connector-version

- **Description:** The version of the connector class, as reported by the connector.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## header-converter-class

- **Description:** The fully qualified class name from header.converter
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## header-converter-version

- **Description:** The version instantiated for header.converter. May be undefined
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## key-converter-class

- **Description:** The fully qualified class name from key.converter
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## key-converter-version

- **Description:** The version instantiated for key.converter. May be undefined
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## offset-commit-avg-time-ms

- **Description:** The average time in milliseconds taken by this task to commit offsets.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## offset-commit-failure-percentage

- **Description:** The average percentage of this task's offset commit attempts that failed.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## offset-commit-max-time-ms

- **Description:** The maximum time in milliseconds taken by this task to commit offsets.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## offset-commit-success-percentage

- **Description:** The average percentage of this task's offset commit attempts that succeeded.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## pause-ratio

- **Description:** The fraction of time this task has spent in the pause state.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## running-ratio

- **Description:** The fraction of time this task has spent in the running state.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## status

- **Description:** The status of the connector task. One of 'unassigned', 'running', 'paused', 'failed', or 'restarting'.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## task-class

- **Description:** The class name of the task.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## task-version

- **Description:** The version of the task.
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## value-converter-class

- **Description:** The fully qualified class name from value.converter
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## value-converter-version

- **Description:** The version instantiated for value.converter. May be undefined
- **Mbean name:** kafka.connect:type=connector-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## transform-class

- **Description:** The class name of the transformation class
- **Mbean name:** kafka.connect:type=connector-transform-metrics,connector="{connector}",task="{task}",transform="{transform}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## transform-version

- **Description:** The version of the transformation class
- **Mbean name:** kafka.connect:type=connector-transform-metrics,connector="{connector}",task="{task}",transform="{transform}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## offset-commit-completion-rate

- **Description:** The average per-second number of offset commit completions that were completed successfully.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## offset-commit-completion-total

- **Description:** The total number of offset commit completions that were completed successfully.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## offset-commit-seq-no

- **Description:** The current sequence number for offset commits.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## offset-commit-skip-rate

- **Description:** The average per-second number of offset commit completions that were received too late and skipped/ignored.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## offset-commit-skip-total

- **Description:** The total number of offset commit completions that were received too late and skipped/ignored.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## partition-count

- **Description:** The number of topic partitions assigned to this task belonging to the named sink connector in this worker.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## put-batch-avg-time-ms

- **Description:** The average time taken by this task to put a batch of sinks records.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## put-batch-max-time-ms

- **Description:** The maximum time taken by this task to put a batch of sinks records.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## sink-record-active-count

- **Description:** The number of records that have been read from Kafka but not yet completely committed/flushed/acknowledged by the sink task.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## sink-record-active-count-avg

- **Description:** The average number of records that have been read from Kafka but not yet completely committed/flushed/acknowledged by the sink task.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## sink-record-active-count-max

- **Description:** The maximum number of records that have been read from Kafka but not yet completely committed/flushed/acknowledged by the sink task.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## sink-record-lag-max

- **Description:** The maximum lag in terms of number of records that the sink task is behind the consumer's position for any topic partitions.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## sink-record-read-rate

- **Description:** The average per-second number of records read from Kafka for this task belonging to the named sink connector in this worker. This is before transformations are applied.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## sink-record-read-total

- **Description:** The total number of records read from Kafka by this task belonging to the named sink connector in this worker, since the task was last restarted.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## sink-record-send-rate

- **Description:** The average per-second number of records output from the transformations and sent/put to this task belonging to the named sink connector in this worker. This is after transformations are applied and excludes any records filtered out by the transformations.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## sink-record-send-total

- **Description:** The total number of records output from the transformations and sent/put to this task belonging to the named sink connector in this worker, since the task was last restarted.
- **Mbean name:** kafka.connect:type=sink-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## poll-batch-avg-time-ms

- **Description:** The average time in milliseconds taken by this task to poll for a batch of source records.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## poll-batch-max-time-ms

- **Description:** The maximum time in milliseconds taken by this task to poll for a batch of source records.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## source-record-active-count

- **Description:** The number of records that have been produced by this task but not yet completely written to Kafka.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## source-record-active-count-avg

- **Description:** The average number of records that have been produced by this task but not yet completely written to Kafka.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## source-record-active-count-max

- **Description:** The maximum number of records that have been produced by this task but not yet completely written to Kafka.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## source-record-poll-rate

- **Description:** The average per-second number of records produced/polled (before transformation) by this task belonging to the named source connector in this worker.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## source-record-poll-total

- **Description:** The total number of records produced/polled (before transformation) by this task belonging to the named source connector in this worker.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## source-record-write-rate

- **Description:** The average per-second number of records written to Kafka for this task belonging to the named source connector in this worker, since the task was last restarted. This is after transformations are applied, and excludes any records filtered out by the transformations.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## source-record-write-total

- **Description:** The number of records output written to Kafka for this task belonging to the named source connector in this worker, since the task was last restarted. This is after transformations are applied, and excludes any records filtered out by the transformations.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## transaction-size-avg

- **Description:** The average number of records in the transactions the task has committed so far.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## transaction-size-max

- **Description:** The number of records in the largest transaction the task has committed so far.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## transaction-size-min

- **Description:** The number of records in the smallest transaction the task has committed so far.
- **Mbean name:** kafka.connect:type=source-task-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## deadletterqueue-produce-failures

- **Description:** The number of failed writes to the dead letter queue.
- **Mbean name:** kafka.connect:type=task-error-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## deadletterqueue-produce-requests

- **Description:** The number of attempted writes to the dead letter queue.
- **Mbean name:** kafka.connect:type=task-error-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## last-error-timestamp

- **Description:** The epoch timestamp when this task last encountered an error.
- **Mbean name:** kafka.connect:type=task-error-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## total-errors-logged

- **Description:** The number of errors that were logged.
- **Mbean name:** kafka.connect:type=task-error-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## total-record-errors

- **Description:** The number of record processing errors in this task.
- **Mbean name:** kafka.connect:type=task-error-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## total-record-failures

- **Description:** The number of record processing failures in this task.
- **Mbean name:** kafka.connect:type=task-error-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## total-records-skipped

- **Description:** The number of records skipped due to errors.
- **Mbean name:** kafka.connect:type=task-error-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/

## total-retries

- **Description:** The number of operations retried.
- **Mbean name:** kafka.connect:type=task-error-metrics,connector="{connector}",task="{task}"
- **Docs:** https://kafka.apache.org/42/operations/monitoring/
