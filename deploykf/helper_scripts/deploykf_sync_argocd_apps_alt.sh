#!/bin/bash

set -e

. ../bin/encpass.sh
# Source: https://github.com/plyint/encpass.sh/blob/master/examples/example.sh

ORIG_DIR="$PWD"

GIT_REPO_DIR="submodules/deployKF"
if [ ! -d "$GIT_REPO_DIR" ]; then
  git pull
  git submodule update --init
fi
git submodule update

# change to the argocd-plugin directory
# cd "$GIT_REPO_DIR""/scripts"

# ensure the script is executable
chmod +x ./sync_argocd_apps.sh

password=$(get_secret main argocd_pass)
export password

# sync all deployKF ArgoCD applications
# ./sync_argocd_apps.sh

# Within each group, there is an additional order defined by the argocd.argoproj.io/sync-wave annotation, this order is NOT respected by the following commands, but is respected by the automated script.

# sync the "deploykf-app-of-apps" application
argocd app sync -l "app.kubernetes.io/name=deploykf-app-of-apps"

# sync the "deploykf-namespaces" application
# NOTE: This will only be present if you are using a remote destination
# argocd app sync -l "app.kubernetes.io/name=deploykf-namespaces"

# sync all applications in the "deploykf-dependencies" group
argocd app sync -l "app.kubernetes.io/component=deploykf-dependencies"

# sync all applications in the "deploykf-core" group
argocd app sync -l "app.kubernetes.io/component=deploykf-core"

# sync all applications in the "deploykf-opt" group
argocd app sync -l "app.kubernetes.io/component=deploykf-opt"

# sync all applications in the "deploykf-tools" group
argocd app sync -l "app.kubernetes.io/component=deploykf-tools"

# sync all applications in the "kubeflow-dependencies" group
argocd app sync -l "app.kubernetes.io/component=kubeflow-dependencies"

# sync all applications in the "kubeflow-tools" group
argocd app sync -l "app.kubernetes.io/component=kubeflow-tools"

unset password

cd "$ORIG_DIR"