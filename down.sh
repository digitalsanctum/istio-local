#!/usr/bin/env bash

set -e

source common.sh

kind delete cluster -n "${CLUSTER_NAME}"

notice "${CLUSTER_NAME} cluster deleted"