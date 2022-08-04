output "vnet_ids" {
  value = values(azurerm_virtual_network.aks-vnets)[*].id
}
output "vnet_names" {
  value = values(azurerm_virtual_network.aks-vnets)[*].name
}
output "rg_name" {
  value = values(azurerm_resource_group.azurerg)[*].id
}

output "subnet_ids" {
  value = values(azurerm_subnet.aks-ah-cluster-subnets)[*].id
}

output "location_names" {
  value = values(azurerm_virtual_network.aks-vnets)[*].location
}

/* output "resource_group_name" {
  value = azurerm_resource_group.azurerg.name
}

output "client_key" {
  value = azurerm_kubernetes_cluster.aks[*].kube_config.0.client_key
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks[*].kube_config.0.client_certificate
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks[*].kube_config.0.cluster_ca_certificate
}

output "cluster_username" {
  value = azurerm_kubernetes_cluster.aks[*].kube_config.0.username
}

output "cluster_password" {
  value = azurerm_kubernetes_cluster.aks[*].kube_config.0.password
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks[*].kube_config_raw
  sensitive = true
}

output "host" {
  value = azurerm_kubernetes_cluster.aks[*].kube_config.0.host
} */


