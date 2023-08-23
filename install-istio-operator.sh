#!/usr/bin/env bash

set -e

source common.sh

notice "Adding Istio Helm repository..."
helm repo add istio https://istio-release.storage.googleapis.com/charts

notice "Updating Helm repo..."
helm repo update

notice "Downloading and extracting ${ISTIO_TARBALL}..."
wget "${ISTIO_DOWNLOAD_BASE_URL}/${ISTIO_TAG}/${ISTIO_TARBALL}"
tar -xzf ${ISTIO_TARBALL}
rm ${ISTIO_TARBALL}

notice "Creating ${ISTIO_NS} namespace..."
kubectl create ns ${ISTIO_NS}

echo
notice "Installing Istio operator..."
helm install -n ${ISTIO_NS} istio-operator ${ISTIO_DIR}/manifests/charts/istio-operator --wait

notice "Waiting for istio-operator pod to be available..."
kubectl wait --for=condition=ready pod -l name=istio-operator -A

sleep 10