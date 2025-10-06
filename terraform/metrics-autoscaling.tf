resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.12.2"
  set {
    name  = "args"
    value = "{--kubelet-insecure-tls}"
  }
}

module "ca_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.39"

  role_name_prefix = "${var.cluster_name}-ca-"
  attach_cluster_autoscaler_policy = true

  oidc_providers = {
    main = {
      provider_arn = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:cluster-autoscaler"]
    }
  }
}

resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  version    = "9.36.0"

  set { name = "autoDiscovery.clusterName" value = module.eks.cluster_name }
  set { name = "awsRegion" value = data.aws_region.current.name }
  set { name = "rbac.serviceAccount.create" value = "true" }
  set { name = "rbac.serviceAccount.name"   value = "cluster-autoscaler" }
  set { name = "rbac.serviceAccount.annotations.eks\.amazonaws\.com/role-arn" value = module.ca_irsa.iam_role_arn }
}
