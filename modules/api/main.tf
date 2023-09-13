resource "kubernetes_service" "heroes_api_svc" {
  metadata {
    name      = var.api_svc_name
    namespace = var.api_namespace
    labels = {
      app = var.api_name
    }
  }

  spec {
    selector = {
      app = var.api_name
    }
    type = "ClusterIP"
    port {
      port        = 80
      target_port = 3000
    }
  }
}

resource "kubernetes_deployment_v1" "heroes_api_deploy" {
  metadata {
    name      = var.api_deploy_name
    namespace = var.api_namespace
    labels = {
      app = var.api_name
    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = var.api_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.api_name
        }
      }
      spec {
        container {
          image = "juanfr97/heroes-api:latest"
          name  = var.api_name
          port {
            container_port = 3000
          }
          env {
            name  = "MONGO_HOST"
            value = "mongo-0.mongo"
          }
          env {
            name  = "MONGO_DATABASE"
            value = "dbheroes"
          }
          env {
            name  = "MONGO_PORT"
            value = "27017"
          }
        }
      }
    }
  }
}

resource "kubectl_manifest" "heroes_api_ingress" {
  yaml_body = <<YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${var.api_name}-ingress
  namespace: ${var.api_namespace}
  annotations:
    cert-manager.io/cluster-issuer: cert-manager
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - ${var.api_host}
    secretName: ${var.api_name}-tls
  rules:
  - host: ${var.api_host}
    http:
      paths:
      - path: "/"
        pathType: Prefix
        backend:
          service:
            name: ${var.api_svc_name}
            port:
              number: 80
  YAML

}