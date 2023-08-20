oc apply --wait=true -f gitops/gitops-operator.yaml
#echo "Approval install-plan"
#PLAN=$(oc get installplan -A | grep openshift-gitops-operator | awk '{print $2}')
#oc patch installplan $PLAN --namespace openshift-operators --type merge --patch '{"spec":{"approved":true}}'

sleep 5 

echo "Add cluster-admin to the openshift-gitops-argocd-application-controller"
oc adm policy add-cluster-role-to-user cluster-admin -z openshift-gitops-argocd-application-controller -n openshift-gitops


