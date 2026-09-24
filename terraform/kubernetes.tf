resource "kubernetes_namespace" "ecommerce" {
  metadata {
    name = "ecommerce"
  }

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}