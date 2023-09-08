module "kubernetes_cluster" {
  source                 = "./modules/cluster"
  cluster_name           = "heroes-cluster"
  region                 = "sfo3"
  kubernetes_version     = "1.27.4-do.0"
  node_pool_name         = "heroes-cluster-nodes"
  node_pool_size         = "s-1vcpu-2gb"
  node_pool_auto_scale   = true
  node_pool_node_count   = 2
  node_pool_min_nodes    = 1
  node_pool_max_nodes    = 2
  DO_TOKEN = var.DO_TOKEN
}

module "ingress" {
    source = "./modules/helm"
    cluster_endpoint = module.kubernetes_cluster.cluster_endpoint
    cluster_ca_certificate = module.kubernetes_cluster.cluster_ca_certificate
    cluster_token = module.kubernetes_cluster.cluster_token
    cluster_id = module.kubernetes_cluster.cluster_id
    cluster_client_certificate = module.kubernetes_cluster.cluster_client_certificate
    cluster_client_key = module.kubernetes_cluster.cluster_client_key
}

