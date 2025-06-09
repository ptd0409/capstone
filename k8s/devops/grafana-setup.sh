helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

kubectl create namespace monitoring

cat <<EOF > grafana-values.yaml
adminUser: admin
adminPassword: grafana123

service:
  type: ClusterIP

ingress:
  enabled: true
  ingressClassName: nginx
  annotations:
    kubernetes.io/ingress.class: nginx
  hosts:
    - grafana.10.0.1.162.nip.io
  tls: [] # Không bật TLS ở đây

persistence:
  enabled: true
  size: 2Gi
EOF

helm upgrade --install grafana grafana/grafana \
  --namespace monitoring \
  --create-namespace \
  --values grafana-values.yaml
