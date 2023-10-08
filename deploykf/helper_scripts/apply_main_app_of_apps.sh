#!/bin/bash

set -e

ORIG_DIR="$PWD"

GIT_REPO_DIR="submodules/deployKF"
if [ ! -d "$GIT_REPO_DIR" ]; then
  git pull
  git submodule update --init
fi
git submodule update

# change to the argocd-plugin directory
cd "$GIT_REPO_DIR""/argocd-plugin"

# apply 'main' app-of-apps
ARGOCD_NAMESPACE="argocd"
kubectl apply -f ../../main/app_of_apps/app-of-apps.yaml --namespace "$ARGOCD_NAMESPACE"

cd "$ORIG_DIR"