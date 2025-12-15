# X-Ray write-only managed policy
data "aws_iam_policy" "adot_xray" {
  arn = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
}

# CloudWatch agent server policy (for EMF / logs / metrics)
data "aws_iam_policy" "adot_cloudwatch" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

module "irsa_adot_collector" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.39.0"

  create_role = true
  role_name   = "AmazonEKS_ADOT_CollectorRole-${module.eks.cluster_name}"

  # This should already work because you used it for ebs-csi
  provider_url = module.eks.oidc_provider

  role_policy_arns = [
    data.aws_iam_policy.adot_xray.arn,
    data.aws_iam_policy.adot_cloudwatch.arn,
  ]

  # Bind specifically to the ADOT collector service account
  oidc_fully_qualified_subjects = [
    "system:serviceaccount:adot-system:adot-apm-collector",
  ]
}

resource "kubernetes_namespace" "adot_system" {
  metadata {
    name = "adot-system"
  }
}

resource "kubernetes_service_account" "adot_apm_collector" {
  metadata {
    name      = "adot-apm-collector"
    namespace = kubernetes_namespace.adot_system.metadata[0].name
    annotations = {
      "eks.amazonaws.com/role-arn" = module.irsa_adot_collector.iam_role_arn
    }
  }
}
