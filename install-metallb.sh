#!/usr/bin/env bash

# https://metallb.universe.tf/

set -e

source common.sh

notice "Installing MetalLB..."

notice "Setting strictARP to 'true'"
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

notice "Applying MetalLB manifests..."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v${METALLB_VERSION}/config/manifests/metallb-native.yaml


