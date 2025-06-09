helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo update

kubectl create namespace gitlab

cat <<EOF > gitlab-values.yaml
global:
  edition: ce
  hosts:
    domain: "gitlab.local"
  ingress:
    enabled: false

certmanager:
  install: false

certmanager-issuer:
  email: "disabled@example.com"
  create: false

nginx-ingress:
  enabled: false

webservice:
  service:
    type: ClusterIP
    externalPort: 80

redis:
  master:
    persistence:
      storageClass: "gp2"

EOF

helm upgrade --install gitlab gitlab/gitlab \
  --namespace gitlab \
  --create-namespace \
  --values gitlab-values.yaml

#helm install gitlab gitlab/gitlab -n gitlab --create-namespace -f gitlab-values.yaml