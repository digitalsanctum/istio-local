#!/usr/bin/env bash

# Reference: https://gateway-api.sigs.k8s.io/v1alpha2/guides/#installing-a-gateway-controller

set -e

source common.sh

notice "Installing Gateway API CRDs..."
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/${K8S_GATEWAY_VERSION}/standard-install.yaml
