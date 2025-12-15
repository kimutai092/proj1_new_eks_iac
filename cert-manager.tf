resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  # Pin a compatible version; you can update later
  version = "v1.15.1"

  # Ensure CRDs are installed
  set {
    name  = "crds.enabled"
    value = "true"
  }
}
