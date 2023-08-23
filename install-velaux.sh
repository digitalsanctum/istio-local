#!/usr/bin/env bash

set -e

source common.sh

notice "Installing Velaux..."

# Requires vela >=v1.6.0-alpha.6

eval "$(${KUBEVELA_BINARY} addon enable velaux)"

#eval "$(vela port-forward -n vela-system addon-velaux 9082:9082)"

