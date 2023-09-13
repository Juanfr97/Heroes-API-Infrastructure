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

variable "api_host" {
  description = "value of the api host"
  type        = string
}

variable "api_svc_name" {
  description = "value of the api service name"
  type        = string
  default     = "heroes-api-svc"
}
variable "api_deploy_name" {
  default = "heroes-api-deploy"
  type    = string
}
variable "api_namespace" {
  default = "heroes-api"
  type    = string
}

variable "api_name" {
  default = "heroes-api"
  type    = string
}