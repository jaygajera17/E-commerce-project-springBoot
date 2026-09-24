resource "kubernetes_deployment" "ecommerce" {
  metadata {
    name      = "ecommerce-app"
    namespace = kubernetes_namespace.ecommerce.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "ecommerce-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "ecommerce-app"
        }
      }

      spec {
        container {
          name = "ecommerce-app"

          image = "${azurerm_container_registry.acr.login_server}/ecommerce-app:1.0"

          image_pull_policy = "Always"

          port {
            container_port = 8080
          }

          env {
            name  = "SERVER_PORT"
            value = "8080"
          }

          env {
            name  = "DB_URL"
            value = "jdbc:mysql://mysql:3306/ecommjava?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
          }

          env {
            name = "DB_USERNAME"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql.metadata[0].name
                key  = "MYSQL_USER"
              }
            }
          }

          env {
            name = "DB_PASSWORD"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql.metadata[0].name
                key  = "MYSQL_PASSWORD"
              }
            }
          }
        }
      }
    }
  }

  depends_on = [
    azurerm_role_assignment.aks_acr_pull,
    kubernetes_stateful_set.mysql
  ]
}
resource "kubernetes_service" "ecommerce" {
  metadata {
    name      = "ecommerce-service"
    namespace = kubernetes_namespace.ecommerce.metadata[0].name
  }

  spec {
    selector = {
      app = "ecommerce-app"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}