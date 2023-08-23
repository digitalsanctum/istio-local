#!/usr/bin/env bash

set -e

source common.sh

echo
notice "Installing cert-manager..."

helm repo add jetstack https://charts.jetstack.io
helm install --create-namespace -n cert-manager-system cert-manager jetstack/cert-manager --version "${CERT_MANAGER_VERSION}" --set installCRDs=true