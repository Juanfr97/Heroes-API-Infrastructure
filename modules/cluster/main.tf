resource "digitalocean_kubernetes_cluster" "heroes_k8s" {
  name    = var.cluster_name
  region  = var.region
  version = var.kubernetes_version

  node_pool {
    name       = var.node_pool_name
    size       = var.node_pool_size
    auto_scale = var.node_pool_auto_scale
    node_count = var.node_pool_node_count
    min_nodes  = var.node_pool_min_nodes
    max_nodes  = var.node_pool_max_nodes
  }
}

resource "kubernetes_namespace" "ns_heroes_api" {
  metadata {
    name = "heroes-api"
  }
}
resource "kubernetes_namespace" "ns_ingress-nginx" {
  metadata {
    name = "ingress-nginx"
  }
  depends_on = [
    time_sleep.wait_for_kubernetes
  ]
}
resource "time_sleep" "wait_for_kubernetes" {

  depends_on = [
    digitalocean_kubernetes_cluster.heroes_k8s
  ]

  create_duration = "10s"
}