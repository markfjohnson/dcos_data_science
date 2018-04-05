#!/usr/bin/env bash
dcos package uninstall --yes dcos-enterprise-cli --cli
dcos package uninstall --yes hdfs
dcos package uninstall --yes marathon-lb
dcos package uninstall --yes cassandra
dcos marathon app remove livy-marathon.json
dcos marathon app remove beakerx.json
dcos package uninstall --yes postgresql
dcos package uninstall --yes kafka
dcos marathon app remove prometheus.json