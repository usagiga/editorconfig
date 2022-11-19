#!/bin/bash

set -euo pipefail

ESC=$(printf '\033')
RESET="${ESC}[0m"
BOLD="${ESC}[1m"
GREEN="${ESC}[32m"
CYAN="${ESC}[36m"

REPO_NAME='editorconfig'
REPO_AUTHOR='usagiga'
REPO_URL="https://github.com/${REPO_AUTHOR}/${REPO_NAME}"

function main() {
    pushd $(git rev-parse --show-toplevel)

    # Register submodule
    echoH1 "Register github.com/${REPO_AUTHOR}}/${REPO_NAME} as submodule"
    git submodule add "${REPO_URL}" '.editorconfig.d'

    # Generate symlink of .editorconfig
    echoH1 "Register github.com/${REPO_AUTHOR}}/${REPO_NAME} as submodule"
    ln -s '.editorconfig.d/.editorconfig' './.editorconfig'

    # Generate symlink of GitHub Workflows
    echoH1 "Generate symlink of .editorconfig"
    mkdir -pv './.github/workflows/'
    ln -s '../../.editorconfig.d/workflows/editorconfig.yml' './.github/workflows/editorconfig.yml'

    # Done
    echoH1 'All tasks are done 🎉'
    popd
}

function echoH1() {
    echo ""
    echo "${BOLD}${GREEN}### $1${RESET}"
    echo ""
}

function echoH2() {
    echo "${CYAN}$ $1${RESET}"
}

main
