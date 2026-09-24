output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_resource_group" {
  value = azurerm_resource_group.rg.name
}

output "application_image" {
  value = "${azurerm_container_registry.acr.login_server}/ecommerce-app:1.0"
}

output "ingress_ip" {
  value = try(
    kubernetes_ingress_v1.ecommerce.status[0].load_balancer[0].ingress[0].ip,
    "Waiting for ingress IP"
  )
}