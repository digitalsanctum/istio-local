#!/usr/bin/env bash

set -e

source common.sh
notice "Enabling sidecar injection for default namespace..."

kubectl label namespace default istio-injection=enabled
kubectl label namespace ${TEAM_NS} istio-injection=enabled
