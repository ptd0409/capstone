helm repo add rancher-alpha https://releases.rancher.com/server-charts/alpha

helm repo update

kubectl create namespace cattle-system

cat <<EOF > rancher-values.yaml
replicas: 1

hostname: rancher.local

ingress:
  enabled: false

service:
  type: ClusterIP

bootstrapPassword: "admin123"

EOF

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.crds.yaml

helm install rancher rancher-alpha/rancher \
  --namespace cattle-system \
  --values rancher-values.yaml \
  --set bootstrapPassword=admin123 \
  --devel
