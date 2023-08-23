#!/usr/bin/env bash

set -e

source common.sh

kubectl create namespace "${TEAM_NS}"
