
resource "kubernetes_secret" "mysql" {
  metadata {
    name      = "mysql-secret"
    namespace = kubernetes_namespace.ecommerce.metadata[0].name
  }

  type = "Opaque"

  data = {
    MYSQL_ROOT_PASSWORD = "root123"
    MYSQL_DATABASE      = "ecommjava"
    MYSQL_USER          = "ecommerce"
    MYSQL_PASSWORD      = "ecommerce123"
  }
}


resource "kubernetes_persistent_volume_claim" "mysql" {
  metadata {
    name      = "mysql-pvc"
    namespace = kubernetes_namespace.ecommerce.metadata[0].name
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    storage_class_name = "managed-csi"

    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }

  wait_until_bound = false
}


resource "kubernetes_stateful_set" "mysql" {
  metadata {
    name      = "mysql"
    namespace = kubernetes_namespace.ecommerce.metadata[0].name
  }

  spec {
    service_name = "mysql"
    replicas     = 1

    selector {
      match_labels = {
        app = "mysql"
      }
    }

    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }

      spec {
        container {
          name  = "mysql"
          image = "mysql:8.0"

          port {
            container_port = 3306
          }

          env {
            name = "MYSQL_ROOT_PASSWORD"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql.metadata[0].name
                key  = "MYSQL_ROOT_PASSWORD"
              }
            }
          }

          env {
            name = "MYSQL_DATABASE"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql.metadata[0].name
                key  = "MYSQL_DATABASE"
              }
            }
          }

          env {
            name = "MYSQL_USER"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql.metadata[0].name
                key  = "MYSQL_USER"
              }
            }
          }

          env {
            name = "MYSQL_PASSWORD"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql.metadata[0].name
                key  = "MYSQL_PASSWORD"
              }
            }
          }

          volume_mount {
            name       = "mysql-storage"
            mount_path = "/var/lib/mysql"
          }
        }

        volume {
          name = "mysql-storage"

          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.mysql.metadata[0].name
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "mysql" {
  metadata {
    name      = "mysql"
    namespace = kubernetes_namespace.ecommerce.metadata[0].name
  }

  spec {
    selector = {
      app = "mysql"
    }

    port {
      port        = 3306
      target_port = 3306
    }

    type = "ClusterIP"
  }
}
