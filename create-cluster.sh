#!/usr/bin/env bash

set -e

source common.sh

kind create cluster --config=- <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: ${CLUSTER_NAME}
nodes:
- role: control-plane
  image: "${KIND_IMAGE}"
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 6443
    hostPort: 6443
    protocol: TCP
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
  - containerPort: 9082
    hostPort: 9082
    protocol: TCP
  - containerPort: 30100
    hostPort: 8443
    protocol: TCP
- role: worker
  image: "${KIND_IMAGE}"
EOF