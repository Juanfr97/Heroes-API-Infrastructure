terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.13.1"
    }
  }
}

provider "helm" {
  kubernetes {
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
}

provider "kubectl" {
  host = var.cluster_endpoint
  cluster_ca_certificate = base64decode(
    var.cluster_ca_certificate
  )
  token = var.cluster_token
  client_certificate = base64decode(
    var.cluster_client_certificate
  )
  client_key = base64decode(
    var.cluster_client_key
  )
  load_config_file = false
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