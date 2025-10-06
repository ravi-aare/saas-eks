# SaaS EKS Deployment (ap-south-1)

This bundle contains Terraform IaC for EKS, Kubernetes manifests, a Dockerfile and app skeleton, a setup guide, QBR, and a simple AWS-style architecture diagram.

## Quickstart
1. Build & push the image to ECR, then set `app_image` if you change the repo name.
2. `cd terraform && terraform init && terraform apply -auto-approve`
3. `aws eks update-kubeconfig --region ap-south-1 --name saas-eks`
4. `cd ../k8s && kubectl apply -f namespace.yaml && kubectl -n web apply -f deployment.yaml -f service.yaml -f ingress.yaml -f hpa.yaml`
5. `kubectl -n web get ingress` → open ALB DNS.

## Image placeholder
Currently: `111111111111.dkr.ecr.ap-south-1.amazonaws.com/saas-web:latest` — replace with your actual ECR URI.

## Notes
- SPOT enabled by default for savings.
- HPA set to 50% CPU target (2–10 replicas).
- Cluster Autoscaler and metrics-server are installed via Helm.
