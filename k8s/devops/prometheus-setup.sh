helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

kubectl create namespace monitoring

cat << EOF > prometheus-values.yaml
grafana:
  enabled: false
alertmanager:
  enabled: false
prometheus:
  service:
    type: ClusterIP
    port: 9090
EOF

helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --values prometheus-values.yaml

helm upgrade --install prometheus-stack prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --values prometheus-values.yaml


kubectl port-forward svc/prometheus-kube-prometheus-prometheus -n monitoring 9090:9090

kubectl --namespace monitoring get secrets prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo



