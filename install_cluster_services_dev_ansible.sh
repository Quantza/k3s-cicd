#!/bin/bash

set -e

echo "Starting..."

# chmod 0755 "$HOME"/.kube
# chmod go-r "$HOME"/.kube/k8s-dev.yaml
# sudo chown $(id -u):$(id -g) $HOME/.kube/k8s-dev.yaml

ROOT_DIR="$PWD"

#

tmpNamespace="production"
kubectl get namespace | grep -q "^$tmpNamespace " || kubectl create namespace $tmpNamespace

#

cd metallb

ansible-playbook deploy.yaml

#

cd ../helm/traefik

ansible-playbook deploy.yaml

#

cd ../certmanager

ansible-playbook deploy.yaml

cd configure

ansible-playbook deploy.yaml

cd ..

#

cd ../../external-dns

ansible-playbook deploy.yaml

#

cd ../helm/switchboard

ansible-playbook deploy.yaml

#

cd ../../argocd

ansible-playbook deploy.yaml

cd "$ROOT_DIR"

