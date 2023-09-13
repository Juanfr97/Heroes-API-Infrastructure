variable "DO_TOKEN" {
  type = string
}

variable "cluster_endpoint" {
  description = "The name of the Kubernetes cluster"
}

variable "cluster_ca_certificate" {
  description = "The Kubernetes cluster CA certificate"
}

variable "cluster_token" {
  description = "The Kubernetes token to use"
}

variable "cluster_id" {
  description = "value of the cluster id"
}

variable "cluster_client_certificate" {
  description = "value of the cluster client certificate"
}

variable "cluster_client_key" {
  description = "value of the cluster client key"
}