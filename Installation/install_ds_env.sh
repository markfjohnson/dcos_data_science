#!/usr/bin/env bash
dcos package install --yes hdfs
dcos package install --yes marathon-lb
dcos package install --yes dcos-enterprise-cli --cli
dcos marathon app add beakerx.json
dcos package install --yes kubernetes --options=k8s_options.json