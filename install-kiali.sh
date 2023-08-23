#!/usr/bin/env bash

set -e

source common.sh

notice "Installing Kiali..."
kubectl apply -f ${ISTIO_DIR}/samples/addons/kiali.yaml