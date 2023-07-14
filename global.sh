#!/bin/bash

if [[ "$#" -ne 2 ]]
then
	echo "Usage: $0 <dir> <clustername>"
	exit 1
fi

DIR=$1
CLUSTERNAME=$2

YAML="---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cluster-config-${DIR}
  namespace: openshift-gitops
spec:
  destination:
    server: 'https://kubernetes.default.svc'
  project: default
  source:
    path: ${DIR}
    repoURL: 'https://github.com/apoczekalewicz/openshift-cluster-config.git'
    targetRevision: HEAD
    helm:
      valueFiles:
        - values-${CLUSTERNAME}.yaml
  syncPolicy:
    automated:
      selfHeal: true
"

echo "$YAML" | oc create -f -
