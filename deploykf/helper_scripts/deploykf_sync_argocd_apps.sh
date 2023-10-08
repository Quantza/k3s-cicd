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
./sync_argocd_apps.sh

unset password

cd "$ORIG_DIR"