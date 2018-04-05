#!/usr/bin/env bash
dcos package install --yes dcos-enterprise-cli --cli
dcos package install --yes hdfs
dcos package install --yes marathon-lb
#dcos package install --yes cassandra
dcos package install --yes spark --options=spark_options.json
dcos marathon app add livy-marathon.json
dcos marathon app add beakerx.json
dcos marathon pod add metrics.json
dcos marathon app add prometheus.json
dcos marathon app add grafana.json
#dcos package install --yes postgresql
#dcos package install --yes kafka
dcos marathon app add prometheus.json

#dcos package install --yes kubernetes --options=k8s_options.json


echo "Setup security rules"
dcos security org groups create dept-a
dcos security org groups create dept-b
dcos security org users create -p password meatloaf
dcos security org users create -p password jsmith
dcos security org users create -p password jdoe
dcos security org groups add_user dept-a jsmith
dcos security org groups add_user dept-b jdoe
dcos security org groups grant dept-a dcos:adminrouter:service:marathon full
dcos security org groups grant dept-a dcos:service:marathon:marathon:services:/dept-a full
dcos security org groups grant dept-a dcos:adminrouter:ops:slave full
dcos security org groups grant dept-a dcos:mesos:master:framework:role:slave_public read
dcos security org groups grant dept-a dcos:mesos:master:executor:app_id:/dept-a read
dcos security org groups grant dept-a dcos:mesos:master:task:app_id:/dept-a read
dcos security org groups grant dept-a dcos:mesos:agent:framework:role:slave_public read
dcos security org groups grant dept-a dcos:mesos:agent:executor:app_id:/dept-a read
dcos security org groups grant dept-a dcos:mesos:agent:task:app_id:/dept-a read
dcos security org groups grant dept-a dcos:mesos:agent:sandbox:app_id:/dept-a read

dcos security org groups grant dept-b dcos:adminrouter:service:marathon full
dcos security org groups grant dept-b dcos:service:marathon:marathon:services:/dept-b full
dcos security org groups grant dept-b dcos:adminrouter:package full

~/dcos_scripts/find_public_node.sh