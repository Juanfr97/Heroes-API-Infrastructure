# modules/kubernetes-cluster/variables.tf
variable "DO_TOKEN" {
  type = string
}
variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
}

variable "region" {
  description = "The region where the Kubernetes cluster will be created"
}

variable "kubernetes_version" {
  description = "The Kubernetes version to use"
}

variable "node_pool_name" {
  description = "The name of the node pool"
}

variable "node_pool_size" {
  description = "The size of the nodes in the node pool"
}

variable "node_pool_auto_scale" {
  description = "Whether to enable node pool auto scaling"
}

variable "node_pool_node_count" {
  description = "The initial number of nodes in the node pool"
}

variable "node_pool_min_nodes" {
  description = "The minimum number of nodes in the node pool"
}

variable "node_pool_max_nodes" {
  description = "The maximum number of nodes in the node pool"
}
