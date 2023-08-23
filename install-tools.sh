#!/usr/bin/env bash

set -e

source common.sh

# TODO: verify brew is installed


notice "Installing tools..."

notice "Detected ${OS} OS"

# set binary path based on mac/linux brew

if [[ ${OS} == "osx" ]]
then
  BREW_BIN_PATH="/opt/homebrew/bin"
else
  BREW_BIN_PATH="/home/linuxbrew/.linuxbrew/bin"
  # prevent "too many open files"
  sudo sysctl fs.inotify.max_user_watches=524288
  sudo sysctl fs.inotify.max_user_instances=512
fi

notice "Found brew bin path: ${LG}${BREW_BIN_PATH}${NC}"

echo -e "Updating brew..."
brew update

# TODO docker
# TODO kubectl
# TODO kustomize


notice "Installing ${LG}Crossplane CLI${NC}"
if [[ -f "${BREW_BIN_PATH}/kubectl-crossplane" ]]
then
  echo "Already installed"
else
  curl -sL https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh | sh
  sudo mv kubectl-crossplane ${BREW_BIN_PATH}
  echo "Done"
fi

notice "Installing ${LG}ArgoCD CLI${NC}..."
if [[ -f "${BREW_BIN_PATH}/argocd" ]]
then
  echo "Already installed"
else
  brew install argocd
  echo "Done"
fi

notice "Installing ${LG}Helm${NC}..."
if [[ -f "${BREW_BIN_PATH}/helm" ]]
then
  echo "Already installed"
else
  brew install helm
  echo "Done"
fi

notice "Installing ${LG}Kind${NC}..."
if [[ -f "${BREW_BIN_PATH}/kind" ]]
then
  echo "Already installed"
else
  brew install kind
  echo "Done"
fi


echo

