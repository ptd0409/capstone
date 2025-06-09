helm install kibana elastic/kibana \
  --namespace logging \
  --values kibana-values.yaml

helm uninstall kibana -n logging
kubectl delete role pre-install-kibana-kibana -n logging --ignore-not-found
kubectl delete configmap kibana-kibana-helm-scripts -n logging --ignore-not-found
kubectl delete serviceaccount pre-install-kibana-kibana -n logging --ignore-not-found
kubectl delete job pre-install-kibana-kibana -n logging --ignore-not-found
kubectl delete rolebinding pre-install-kibana-kibana -n logging --ignore-not-found