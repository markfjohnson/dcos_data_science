#!/usr/bin/env bash
dcos spark run  --submit-args="https://raw.githubusercontent.com/markfjohnson/dcos_spark_demo/master/hdfs_spark/hdfs_spark_write.py" --verbose
