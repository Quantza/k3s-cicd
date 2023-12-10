#!/bin/bash

set -eou pipefail
namespace=$1
kubeconfig_yaml=$2
if [ -z "$namespace" ]
then
  echo "This script requires a namespace argument input. None foun#d. Exiting."
  exit 1
fi
kubectl --kubeconfig "$kubeconfig_yaml" get namespace $namespace -o json | jq '.spec = {"finalizers":[]}' > rknf_tmp.json
kubectl --kubeconfig "$kubeconfig_yaml" proxy &
sleep 5
curl -H "Content-Type: application/json" -X PUT --data-binary @rknf_tmp.json http://localhost:8001/api/v1/namespaces/$namespace/finalize
pkill -9 -f "kubectl proxy"
rm rknf_tmp.json

# kubectl get namespace "$tmpNamespace" -o json \
#   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
#   | kubectl replace --raw "/api/v1/namespaces/""$tmpNamespace""/finalize" -f -