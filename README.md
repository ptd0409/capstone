# Web App Overview

## Web App

- **Frontend**: Single Page Application (SPA) contains user, email, item, and quantity input.
- **Backend**:
  - `microservice1`: handles user and email.
  - `microservice2`: handles item and quantity.

---

## Set Up

1. Change to the appropriate Terraform directory:
   ```bash
   cd terraform/nonprod # or terraform/prod
   ```
2. Configure AWS credentials:
   ```bash
   aws configure
   ```
3. Apply Terraform with environment-specific variables:
   ```bash
   terraform apply -var-file=envs/nonprod.tfvars (or prod.tfvars)
   ```
4. Update kubeconfig for EKS:
   ```bash
   aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
   ```
5. If modifying frontend:
   ```bash
   npm run build
   # Then build Docker image
   ```
6. If modifying backend:
   ```bash
   mvn clean package
   # Then build Docker image
   ```
7. Apply Kubernetes manifests in order:
   ```bash
   kubectl apply -f sc-gp2.yaml
   kubectl apply -f namespace.yaml
   kubectl apply -f db-secret.yaml
   kubectl apply -f postgres.yaml
   kubectl apply -f microservice1.yaml
   kubectl apply -f microservice2.yaml
   kubectl apply -f spa.yaml
   kubectl apply -f ingress.yaml
   ```
8. Deploy services like Jenkins, GitLab, Grafana, Rancher, Harbor... in Kubernetes.
9. Install ingress-nginx controller:
   ```bash
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.1/deploy/static/provider/cloud/deploy.yaml
   ```
10. Get the external IP of ingress-nginx:
    ```bash
    kubectl get svc -n ingress-nginx
    ```
11. Copy the `EXTERNAL-IP` and add it to DNS Records in Cloudflare.
12. Access the domain.

---

## Workflow

- **SPA**:
  - Inputs username and email → sends API request to `microservice1`.
  - Inputs item and quantity → sends API request to `microservice2`.
- **microservice1**:
  - Receives data from SPA and returns list of users and emails in JSON format.
- **microservice2**:
  - Receives data from SPA and returns list of items and quantities in JSON format.

---

## Infrastructure

- **Clusters**:
  - 2 EKS clusters: one for non-production and one for production.
- **Deployments**:
  - `spa`, `microservice1`, `microservice2`, `database`.
- **Additional Services**:
  - Each service (e.g., GitLab, Grafana, Prometheus, Harbor, Rancher...) has an internal service accessible via localhost.
- **Ingress**:
  - One ingress-nginx controller.
- **Storage**:
  - One `gp2` StorageClass for PVC.
- **Domain**:
  - Hosted at: [https://blooperry.com](https://blooperry.com)

## Git branch strategy
| **branch type** | **Purpose**                     | **(Deploy to)**                  | **Pipeline**            |
|-----------------|---------------------------------|----------------------------------|-------------------------|
| `develop`       | Merge feature                   | `dev`                            | `ci-cd-nonprod.yaml`    |
| `feature/*`     | New features                    | `dev`                            | `ci-cd-nonprod.yaml`    |
| `hotfix/*`      | Fix urgent bug                  | `staging`, rồi merge `main`      | `ci-cd-prod.yaml`       |
| `release/*`     | Preparing for release           | `uat`                            | `ci-cd-prod.yaml`       |
| `main`          | Production                      | `staging → production`           | `ci-cd-prod.yaml`       |

## CI/CD

- **Non-production**:
  - Integrate and deploy
- **Production**:
  - Do not auto deploy