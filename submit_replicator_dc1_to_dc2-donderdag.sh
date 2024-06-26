#!/bin/bash

HEADER="Content-Type: application/json"
DATA=$( cat << EOF
{
  "name": "replicator-dc1-to-dc2-donderdag",
  "config": {
    "connector.class": "io.confluent.connect.replicator.ReplicatorSourceConnector",
    "topic.whitelist": "donderdag",
    "key.converter": "io.confluent.connect.replicator.util.ByteArrayConverter",
    "value.converter": "io.confluent.connect.replicator.util.ByteArrayConverter",
    "src.kafka.bootstrap.servers": "broker-dc1:29091",
    "src.consumer.group.id": "replicator-dc1-to-dc2-donderdag",
    "src.consumer.interceptor.classes": "io.confluent.monitoring.clients.interceptor.MonitoringConsumerInterceptor",
    "src.consumer.confluent.monitoring.interceptor.bootstrap.servers": "broker-dc2:29092",
    "src.kafka.timestamps.topic.replication.factor": 1,
    "src.kafka.timestamps.producer.interceptor.classes": "io.confluent.monitoring.clients.interceptor.MonitoringProducerInterceptor",
    "src.kafka.timestamps.producer.confluent.monitoring.interceptor.bootstrap.servers": "broker-dc2:29092",
    "dest.kafka.bootstrap.servers": "broker-dc2:29092",
    "confluent.topic.replication.factor": 1,
    "provenance.header.enable": "true",
    "header.converter": "io.confluent.connect.replicator.util.ByteArrayConverter",
    "tasks.max": "4"
  }
}
EOF
)

curl -X POST -H "${HEADER}" --data "${DATA}" http://localhost:8382/connectors
