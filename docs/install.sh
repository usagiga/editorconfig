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

SRC_DIR='./.editorconfig.d'
WORKFLOWS_SRC_DIR="${SRC_DIR}/workflows"
WORKFLOWS_DST_DIR='./.github/workflows'

function main() {
    pushd $(git rev-parse --show-toplevel)

    # Register / update submodule
    echoH1 "Register github.com/${REPO_AUTHOR}/${REPO_NAME} as submodule"
    HAS_SUBMODULE=$(git submodule status | grep '.editorconfig.d' || echo '')
    if [[ -z ${HAS_SUBMODULE} ]]; then
        git submodule add "${REPO_URL}" "${SRC_DIR}"
    else
        pushd "${SRC_DIR}"
        git switch master
        git pull
        popd
    fi

    # Copy .editorconfig
    echoH1 "Copy .editorconfig"
    cp "${SRC_DIR}/.editorconfig" './.editorconfig'

    # Copy GitHub Actions workflows
    echoH1 "Copy workflows for GitHub Actions"
    mkdir -pv "${WORKFLOWS_DST_DIR}"
    cp "${WORKFLOWS_SRC_DIR}/editorconfig.yml" "${WORKFLOWS_DST_DIR}/editorconfig.yml"

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
