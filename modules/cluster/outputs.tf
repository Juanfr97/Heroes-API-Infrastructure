output "cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.heroes_k8s.endpoint
}
output "cluster_ca_certificate" {
  value = digitalocean_kubernetes_cluster.heroes_k8s.kube_config.0.cluster_ca_certificate
}
output "cluster_name" {
  value = digitalocean_kubernetes_cluster.heroes_k8s.name
}
output "cluster_id" {
  value = digitalocean_kubernetes_cluster.heroes_k8s.id
}
output "cluster_token" {
  value = digitalocean_kubernetes_cluster.heroes_k8s.kube_config.0.token
}
output "cluster_client_certificate" {
  value = digitalocean_kubernetes_cluster.heroes_k8s.kube_config.0.client_certificate
}

output "cluster_client_key" {
  value = digitalocean_kubernetes_cluster.heroes_k8s.kube_config.0.client_key

}


