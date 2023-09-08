module "cert-manager" {
  source  = "terraform-iaac/cert-manager/kubernetes"
  version = "2.5.0"
  # insert the 1 required variable here
  cluster_issuer_email = var.cert_manager_email
}
resource "helm_release" "nginx_ingress" {
  name       = "nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.7.1" # Reemplaza con la versión que desees

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }
}
