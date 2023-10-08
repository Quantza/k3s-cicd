#!/bin/bash

ORIG_DIR="$PWD"

. ./helper_scripts/deploykf_as_argocd_patch.sh

. ./helper_scripts/apply_main_app_of_apps.sh

. ./helper_scripts/deploykf_sync_argocd_apps.sh

cd "$ORIG_DIR"

echo "Done."