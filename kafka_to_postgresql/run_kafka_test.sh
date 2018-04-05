#!/usr/bin/env bash

dcos spark run --docker-image="markfjohnson/spark_pandas" --submit-args="https://raw.githubusercontent.com/markfjohnson/dcos_spark_demo/master/kafka_spark/kafka_producer_example.py" --verbose


dcos spark run --docker-image="markfjohnson/spark_pandas" --submit-args="https://raw.githubusercontent.com/markfjohnson/dcos_spark_demo/master/kafka_spark/kafka_consumer_example.py" --verbose
