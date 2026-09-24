resource "kubernetes_ingress_v1" "ecommerce" {
  metadata {
    name      = "ecommerce-ingress"
    namespace = kubernetes_namespace.ecommerce.metadata[0].name
  }

  spec {
    ingress_class_name = "webapprouting.kubernetes.azure.com"

    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.ecommerce.metadata[0].name

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }

  depends_on = [
    azurerm_kubernetes_cluster.aks,
    kubernetes_service.ecommerce
  ]
}