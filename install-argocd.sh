#!/usr/bin/env bash

set -e

source common.sh

echo
notice "Creating argocd namespace..."
kubectl create namespace argocd

echo
notice "Installing ArgoCD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
echo "Done!"
