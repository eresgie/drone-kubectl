#!/bin/bash

if [[ -n ${KUBERNETES_TOKEN} ]]; then
  KUBERNETES_TOKEN=$KUBERNETES_TOKEN
fi

if [[ -n ${KUBERNETES_SERVER} ]]; then
  KUBERNETES_SERVER=$KUBERNETES_SERVER
fi

if [[ -n ${KUBERNETES_CERT} ]]; then
  KUBERNETES_CERT=${KUBERNETES_CERT}
fi

kubectl config set-credentials default --token="${KUBERNETES_TOKEN}"
if [[ -n ${KUBERNETES_CERT} ]]; then
  echo "${KUBERNETES_CERT}" | base64 -d >ca.crt
  kubectl config set-cluster default --server="${KUBERNETES_SERVER}" --certificate-authority=ca.crt
else
  echo "WARNING: Using insecure connection to cluster"
  kubectl config set-cluster default --server="${KUBERNETES_SERVER}" --insecure-skip-tls-verify=true
fi

kubectl config set-context default --cluster=default --user=default
kubectl config use-context default

if [[ -n ${PLUGIN_KUBECTL} ]]; then
  kubectl "${PLUGIN_KUBECTL}"
fi
