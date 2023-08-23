#!/usr/bin/env bash

set -e

source common.sh

notice "           kind cidr: ${KIND_CIDR}"
address_range="172.24.255.200-172.24.255.250"
notice "metallb address pool: ${address_range}"

sleep 60

notice "Setting up MetalLB Address Pool..."
kubectl apply -f - <<EOF
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default
  namespace: metallb-system
spec:
  addresses:
  - ${address_range}
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
EOF

