#!/usr/bin/env bash

set -e

source common.sh

# Order is important here
./install-tools.sh
#./create-cluster.sh
#./install-metallb.sh
#./install-metallb-address-pool.sh
#./create-namespaces.sh
#./enable-sidecar-injection.sh
#./install-cert-manager.sh
#./install-gateway-api-crds.sh
./install-istio-operator.sh
./install-istio-profile.sh
#./install-argocd.sh
./install-kubevela.sh
./install-kubevela-definitions.sh
# velaux requires vela >=v1.6.0-alpha.6
#./install-velaux.sh

#./install-sleep.sh

# TODO: Display URLs

notice "Cluster is ready!"
