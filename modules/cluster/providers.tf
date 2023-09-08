// Definición del Proveedor Cloud
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}
provider "digitalocean" {
  token = var.DO_TOKEN
}
provider "kubernetes" {
  host = digitalocean_kubernetes_cluster.heroes_k8s.endpoint
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.heroes_k8s.kube_config[0].cluster_ca_certificate
  )
  token = digitalocean_kubernetes_cluster.heroes_k8s.kube_config.0.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "doctl"
    args = ["kubernetes", "cluster", "kubeconfig", "exec-credential",
    "--version=v1beta1", digitalocean_kubernetes_cluster.heroes_k8s.id]
  }
}





