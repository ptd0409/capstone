### After running terraform:
1. aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_name}
2. kubectl apply -f sc-gp2.yaml -> namespace.yaml -> db-secret.yaml -> postgres.yaml -> microservice1.yaml -> microservice2.yaml -> spa.yaml -> ingress.yaml
3. kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.1/deploy/static/provider/cloud/deploy.yaml
4. kubectl get svc -n ingress-nginx
# Copy external-IP from service of ingress nginx and paste to DNS -> Records in CloudFlare