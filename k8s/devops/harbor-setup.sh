helm repo add harbor https://helm.goharbor.io

helm repo update

kubectl create namespace harbor

cat <<EOF > harbor-values.yaml
expose:
  type: ingress
  ingress:
    hosts:
      core: harbor.10.0.1.162.nip.io
    controller: default
    ingressClassName: nginx
    tls:
      enabled: false

externalURL: http://harbor.10.0.1.162.nip.io

harborAdminPassword: Harbor12345

persistence:
  persistentVolumeClaim:
    registry:
      size: 5Gi
    jobservice:
      size: 1Gi
    database:
      size: 1Gi
    redis:
      size: 1Gi
    trivy:
      size: 5Gi
EOF

helm upgrade --install harbor harbor/harbor \
  --namespace harbor \
  --values harbor-values.yaml
