#!/usr/bin/env bash

set -e

source common.sh

notice "Installing sleep..."
kubectl apply -f apps/sleep/sleep.yaml

export SLEEP_POD=$(kubectl get pod -l app=sleep -o jsonpath={.items..metadata.name})
echo "SLEEP_POD: ${SLEEP_POD}"
