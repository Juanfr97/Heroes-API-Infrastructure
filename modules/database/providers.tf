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
  host = var.cluster_endpoint
  cluster_ca_certificate = base64decode(
    var.cluster_ca_certificate
  )
  token = var.cluster_token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "doctl"
    args = ["kubernetes", "cluster", "kubeconfig", "exec-credential",
    "--version=v1beta1", var.cluster_id]
  }
}