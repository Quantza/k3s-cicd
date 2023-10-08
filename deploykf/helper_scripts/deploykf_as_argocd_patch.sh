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

# patch argocd (with the deploykf plugin)
# WARNING: this will apply into your current kubectl context
./patch_argocd.sh

cd "$ORIG_DIR"