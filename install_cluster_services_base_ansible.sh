#!/bin/bash

set -e

echo "Starting..."

chmod 0755 "$HOME"/.kube
chmod go-r "$HOME"/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

ROOT_DIR="$PWD"

#

tmpNamespace="production"
kubectl get namespace | grep -q "^$tmpNamespace " || kubectl create namespace $tmpNamespace

#

cd metallb

ansible-playbook deploy.yaml
cd ..

#

cd helm/traefik

helm repo add traefik https://helm.traefik.io/traefik
helm repo update
ansible-playbook deploy.yaml

#

cd ../certmanager

helm repo add jetstack https://charts.jetstack.io
helm repo update

ansible-playbook deploy.yaml

#

cd ../../external-dns

ansible-playbook deploy.yaml

#

cd ../helm/switchboard

ansible-playbook deploy.yaml

#

tmpNamespace="argocd"
kubectl get namespace | grep -q "^$tmpNamespace " || kubectl create namespace $tmpNamespace
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

#

echo "Done."

echo "Default pass for ArgoCD..."
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

cd "$ROOT_DIR"

