#!/usr/bin/env bash

function my_os() {
  if [ "$(uname)" == "Darwin" ]; then
      echo "osx"
      exit 0
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
      echo "linux"
      exit 0
  fi
  exit 1
}

function my_arch() {
  if [ "$(arch)" == "x86_64" ]; then
    echo "amd64"
    exit 0
  elif [ "$(arch)" == "arm64" ]; then
    echo "arm64"
    exit 0
  fi
  exit 1
}

function notice() {
  msg="$1"
  echo
  echo -e "${LG}==> ${msg}${NC}"
  echo
}

function get_version() {
  name="$1"
  cat versions.json | jq -r ".${name}"
}

function get_version_test() {
  names=( "cert_manager" "istio" "kubernetes" "kubernetes_gateway" "kubevela" "metallb" )
  for name in "${names[@]}"; do
    echo "${name}: $(get_version "${name}")"
  done
}

LG='\e[92m' # Light Green
NC='\e[0m'  # no color

# Available `kind` images from https://github.com/kubernetes-sigs/kind/releases:
#1.26: kindest/node:v1.26.0@sha256:691e24bd2417609db7e589e1a479b902d2e209892a10ce375fab60a8407c7352
#1.25: kindest/node:v1.25.3@sha256:f52781bc0d7a19fb6c405c2af83abfeb311f130707a0e219175677e366cc45d1
#1.24: kindest/node:v1.24.7@sha256:577c630ce8e509131eab1aea12c022190978dd2f745aac5eb1fe65c0807eb315
#1.23: kindest/node:v1.23.13@sha256:ef453bb7c79f0e3caba88d2067d4196f427794086a7d0df8df4f019d5e336b61
#1.22: kindest/node:v1.22.15@sha256:7d9708c4b0873f0fe2e171e2b1b7f45ae89482617778c1c875f1053d4cef2e41
#1.21: kindest/node:v1.21.14@sha256:9d9eb5fb26b4fbc0c6d95fa8c790414f9750dd583f5d7cee45d92e8c26670aa1
#1.20: kindest/node:v1.20.15@sha256:a32bf55309294120616886b5338f95dd98a2f7231519c7dedcec32ba29699394
#1.19: kindest/node:v1.19.16@sha256:476cb3269232888437b61deca013832fee41f9f074f9bed79f57e4280f7c48b7

KIND_IMAGE="kindest/node:v1.23.13@sha256:ef453bb7c79f0e3caba88d2067d4196f427794086a7d0df8df4f019d5e336b61"

# Available `istio` tags:
# 1.18.0-alpha.0
# 1.17.1
# 1.16.3
# 1.15.6

ISTIO_DOWNLOAD_BASE_URL="https://github.com/istio/istio/releases/download"
ISTIO_HUB="docker.io/istio"
ISTIO_TAG="$(get_version istio)"

CLUSTER_NAME="test"
OS="$(my_os)"
ARCH="$(my_arch)"
OS_ARCH="${OS}-${ARCH}"
ISTIO_TARBALL="istio-${ISTIO_TAG}-${OS_ARCH}.tar.gz"
ISTIO_DIR="istio-${ISTIO_TAG}"
ISTIO_NS="istio-system"
ISTIO_PROFILE="default"
TEAM_NAME="test"
TEAM_NS="team-${TEAM_NAME}"

CERT_MANAGER_VERSION="v$(get_version cert_manager)"

# https://github.com/kubevela/kubevela/releases/download/v1.7.4/vela-v1.7.4-linux-amd64.tar.gz
# point this to a local clone of kubevela-definitions
KUBEVELA_DEFINITIONS_ROOT_DIR="${HOME}/projects/kubevela-definitions"
KUBEVELA_DOWNLOAD_BASE_URL="https://github.com/kubevela/kubevela/releases/download"
KUBEVELA_VERSION="v"$(get_version kubevela)""
KUBEVELA_ARCH="$ARCH"
KUBEVELA_OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
KUBEVELA_TRIPLE="${KUBEVELA_VERSION}-${KUBEVELA_OS}-${KUBEVELA_ARCH}"

KUBEVELA_DOWNLOAD_URL="${KUBEVELA_DOWNLOAD_BASE_URL}/${KUBEVELA_VERSION}/vela-${KUBEVELA_TRIPLE}.tar.gz"
KUBEVELA_INSTALL_DIR="$(pwd)/bin/kubevela/${KUBEVELA_VERSION}"
KUBEVELA_BINARY="${KUBEVELA_INSTALL_DIR}/vela"


K8S_GATEWAY_VERSION="v$(get_version kubernetes_gateway)"

METALLB_VERSION="$(get_version metallb)"
KIND_CIDR="$(docker network inspect kind | jq -r '.[].IPAM.Config[0].Subnet')"

APP_NAME="test-app"
