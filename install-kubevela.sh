#!/usr/bin/env bash

set -e

source common.sh

notice "Installing Kubevela binary..."

if [[ -f "${KUBEVELA_BINARY}" ]]
then
  echo "Kubevela binary already installed"
else
  KUBEVELA_TMP_DIR=$(mktemp -d)
  KUBEVELA_OUTPUT="${KUBEVELA_TMP_DIR}/vela-${KUBEVELA_TRIPLE}.tar.gz"
  echo "Downloading ${KUBEVELA_DOWNLOAD_URL} to ${KUBEVELA_OUTPUT}"
  curl --location \
    --output "${KUBEVELA_OUTPUT}" \
    --silent "${KUBEVELA_DOWNLOAD_URL}"
  tar xf "${KUBEVELA_OUTPUT}"
  mkdir -p "${KUBEVELA_INSTALL_DIR}"
  mv "./${KUBEVELA_OS}-${KUBEVELA_ARCH}/vela" ${KUBEVELA_BINARY}
  chmod +x ${KUBEVELA_BINARY}
  rm -rf "./${KUBEVELA_OS}-${KUBEVELA_ARCH}"
  echo "Done"
fi

notice "Adding ${KUBEVELA_INSTALL_DIR} to PATH..."
export PATH="${KUBEVELA_INSTALL_DIR}:$PATH"

notice "Installing Kubevela in cluster..."
helm repo add kubevela https://charts.kubevela.net/core
helm repo update
helm install --create-namespace -n vela-system test kubevela/vela-core --set multicluster.enabled=true --version ${KUBEVELA_VERSION} --wait
