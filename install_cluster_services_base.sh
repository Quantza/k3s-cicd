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

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.11/config/manifests/metallb-native.yaml

cd metallb/manifests

kubectl apply -f service-pool.yaml --wait

#

cd ../../helm/traefik

helm repo add traefik https://helm.traefik.io/traefik
helm repo update
tmpNamespace="traefik"
kubectl get namespace | grep -q "^$tmpNamespace " || kubectl create namespace $tmpNamespace

helm upgrade -i --namespace=traefik traefik traefik/traefik --values=traefik-values.yaml
kubectl apply -f manifests/middleware.yaml

tmpNamespace="my-nginx"
kubectl get namespace | grep -q "^$tmpNamespace " || kubectl create namespace $tmpNamespace

kubectl apply -f manifests/ingress.yaml --wait
kubectl apply -f manifests/ingress-routes.yaml

kubectl apply -f manifests/ingress-service-nginx.yaml --wait

#

cd ../certmanager

helm repo add jetstack https://charts.jetstack.io
helm repo update
tmpNamespace="cert-manager"
kubectl get namespace | grep -q "^$tmpNamespace " || kubectl create namespace $tmpNamespace
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.1/cert-manager.crds.yaml
helm upgrade -i cert-manager jetstack/cert-manager --namespace cert-manager --values=cert-values.yaml --version v1.13.1

kubectl apply -f manifests/issuer.yaml -f manifests/resolver_api.yaml -f manifests/local_certs.yaml

#

cd ../harbor

helm repo add harbor https://helm.goharbor.io
helm repo update

helm upgrade -i harbor harbor/harbor \
  --create-namespace \
  --namespace production \
  -f harbor-values.yaml

#

cd ../../external-dns

tmpNamespace="external-dns"
kubectl get namespace | grep -q "^$tmpNamespace " || kubectl create namespace $tmpNamespace

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/external-dns/master/docs/contributing/crd-source/crd-manifest.yaml
kubectl apply -f manifests/external-dns-deployment.yaml

#

cd ../helm/switchboard

helm upgrade -i switchboard oci://ghcr.io/borchero/charts/switchboard \
  --create-namespace \
  --namespace switchboard \
  -f switchboard-values.yaml

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

