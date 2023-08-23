#!/usr/bin/env bash

set -e

source common.sh

echo
notice "Installing '${ISTIO_PROFILE}' Istio profile..."
kubectl apply -f - <<EOF
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  namespace: $ISTIO_NS
  name: istiocontrolplane
spec:
  profile: $ISTIO_PROFILE
  hub: $ISTIO_HUB
  tag: $ISTIO_TAG
  meshConfig:
    accessLogFile: /dev/stdout
    accessLogEncoding: JSON
    defaultHttpRetryPolicy:
      attempts: 0
EOF
