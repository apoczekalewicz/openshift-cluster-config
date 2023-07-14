oc apply --wait=true -f bootstrap/gitops/gitops-operator.yaml
echo "Approval install-plan"
PLAN=$(oc get installplan -A | grep openshift-gitops-operator | awk '{print $2}')
oc patch installplan $PLAN --namespace openshift-operators --type merge --patch '{"spec":{"approved":true}}'

sleep 5 

echo "Add cluster-admin to the openshift-gitops-argocd-application-controller"
oc adm policy add-cluster-role-to-user cluster-admin -z openshift-gitops-argocd-application-controller -n openshift-gitops
echo ArgoCD route:
oc get -n openshift-gitops route
echo Admin password:
oc get -n openshift-gitops secret openshift-gitops-cluster -o json | jq -r '.data | .[]' | base64 -d ; echo ""

