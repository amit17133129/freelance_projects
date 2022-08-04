# Create stateless "apigeertime" Node Pool for Apigee Hybrid Runtime Services
resource "azurerm_kubernetes_cluster_node_pool" "apigeertime" {
  for_each              = var.aks_clusters
  availability_zones    = each.value.nodepools["apigeertime"].availability_zones #var.apigee_node_pool_availability_zones[terraform.workspace]
  enable_auto_scaling   = each.value.nodepools["apigeertime"].enable_auto_scaling
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks[each.key].id
  min_count             = each.value.nodepools["apigeertime"].min_count
  max_count             = each.value.nodepools["apigeertime"].max_count
  max_pods              = each.value.nodepools["apigeertime"].max_pods
  mode                  = each.value.nodepools["apigeertime"].mode
  name                  = "${each.key == "westeurope" ? "mwe" : "mue2"}${var.environment == "prod" ? "p" : "d"}clart01"
  vm_size               = each.value.nodepools["apigeertime"].vm_size             #var."apigeertime"_nodepools.vm_size
  vnet_subnet_id        = azurerm_subnet.aks-ah-cluster-subnets[each.key].id #pulled from data block or networking
}

# Create stateful "apigeedata" Node Pool for Cassandra DB
resource "azurerm_kubernetes_cluster_node_pool" "apigeedata" {
  for_each              = var.aks_clusters
  availability_zones    = each.value.nodepools["apigeertime"].availability_zones
  #zones                 = var.environment == "prod" ? [1, 2, 3] : [1] # If Prod, [1], [2], [3], else [1]
  enable_auto_scaling   = each.value.nodepools["apigeedata"].enable_auto_scaling
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks[each.key].id
  min_count             = each.value.nodepools["apigeedata"].min_count
  max_count             = each.value.nodepools["apigeedata"].max_count
  max_pods              = each.value.nodepools["apigeedata"].max_pods
  mode                  = each.value.nodepools["apigeedata"].mode
  name                  = "${each.key == "westeurope" ? "mwe" : "mue2"}${var.environment == "prod" ? "p" : "d"}cladt01"
  vm_size               = each.value.nodepools["apigeedata"].vm_size             #var."apigeertime"_nodepools.vm_size
  vnet_subnet_id        = azurerm_subnet.aks-ah-cluster-subnets[each.key].id #pulled from data block or networking
}
