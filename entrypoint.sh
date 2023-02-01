#!/bin/sh
set -e

namespace=$1
name=$2
timeout=$3
wait=$4

params=""

if [ ! -z "$OKTETO_CA_CERT" ]; then
   echo "Custom certificate is provided"
   echo "$OKTETO_CA_CERT" > /usr/local/share/ca-certificates/okteto_ca_cert.crt
   update-ca-certificates
fi

if [ ! -z "$namespace" ]; then
params="${params} --namespace $namespace"
fi

if [ ! -z "$name" ]; then
params="${params} --name $name"
fi

if [ ! -z "$timeout" ]; then
params="${params} --timeout $timeout"
fi

if [ "$timeout" == "wait" ]; then
params="${params} --wait"
fi

echo running: okteto deploy $params on $(pwd)
okteto deploy $params
