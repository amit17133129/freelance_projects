
# Create Virtual Network
resource "azurerm_virtual_network" "aks-vnets" {
  for_each            = var.aks_clusters
  name                = "vnet-${var.environment == "prod" ? "prod" : "dev"}-${each.key}"
  location            = each.key
  resource_group_name = azurerm_resource_group.azurerg[each.key].name #each.value.rg_name
  address_space       = each.value.vnets_cidrs
}

# Create a Subnets for AKS Cluster
resource "azurerm_subnet" "aks-ah-cluster-subnets" {
  for_each             = azurerm_virtual_network.aks-vnets
  name                 = "subnet-${var.environment == "prod" ? "prod" : "dev"}-${each.value.location}-01"
  virtual_network_name = each.value.name
  resource_group_name  = each.value.resource_group_name #azurerm_resource_group.azure_rg.name
  address_prefixes     = var.aks_clusters[each.value.location].aks_subnet_cidrs
}
/* 
resource "azurerm_virtual_network_peering" "vnets-peering-1-2" {
  name                      = "peer-vnet1-to-vnet2"
  resource_group_name       = data.terraform_remote_state.backend.outputs.rg_name[0]
  virtual_network_name      = data.terraform_remote_state.backend.outputs.vnet_names[0]
  remote_virtual_network_id = data.terraform_remote_state.backend.outputs.vnet_ids[1]
}

resource "azurerm_virtual_network_peering" "vnets-peering-2-1" {
  name                      = "peer-vnet2-to-vnet1"
  resource_group_name       = data.terraform_remote_state.backend.outputs.rg_name[1]
  virtual_network_name      = data.terraform_remote_state.backend.outputs.vnet_names[1]
  remote_virtual_network_id = data.terraform_remote_state.backend.outputs.vnet_ids[0]
} */

/* resource "azurerm_virtual_network_peering" "vnets-peering-1-2" {
  for_each                  = azurerm_virtual_network.aks-vnets
  name                      = "peer-vnet1-to-vnet2-${each.key}"
  resource_group_name       = each.value.resource_group_name  #azurerm_resource_group.azurerg.name
  virtual_network_name      = each.value.name #azurerm_virtual_network.aks-vnets.count.index[0].name
  remote_virtual_network_id = strrev(each.value.id) #azurerm_virtual_network.aks-vnets.count.index[1].id
} */

/* resource "azurerm_virtual_network_peering" "vnets-peering-2-1" {
  for_each                  = azurerm_virtual_network.aks-vnets
  name                      = "peer-vnet2-to-vnet1"
  resource_group_name       = azurerm_resource_group.azurerg.name
  virtual_network_name      = each.value.name #azurerm_virtual_network.aks-vnets.count.index[1].name
  remote_virtual_network_id = each.value.id #azurerm_virtual_network.aks-vnets.count.index[0].id
} */
#####################################################################

# Following applies only for 3 regions deployment.
# Peer all VNets in 3 regions.

#resource "azurerm_virtual_network_peering" "vnets-peering-1-2" {
#  name                      = "peer-vnet1-to-vnet2"
#  resource_group_name       = azurerm_resource_group.azurerg.name
#  virtual_network_name      = azurerm_virtual_network.aks-vnets[0].name
#  remote_virtual_network_id = azurerm_virtual_network.aks-vnets[1].id
#}

#resource "azurerm_virtual_network_peering" "vnets-peering-2-1" {
#  name                      = "peer-vnet2-to-vnet1"
#  resource_group_name       = azurerm_resource_group.azurerg.name
#  virtual_network_name      = azurerm_virtual_network.aks-vnets[1].name
#  remote_virtual_network_id = azurerm_virtual_network.aks-vnets[0].id
#}

#resource "azurerm_virtual_network_peering" "vnets-peering-1-3" {
#  name                      = "peer-vnet1-to-vnet3"
#  resource_group_name       = azurerm_resource_group.azurerg.name
#  virtual_network_name      = azurerm_virtual_network.aks-vnets[0].name
#  remote_virtual_network_id = azurerm_virtual_network.aks-vnets[2].id
#}

#resource "azurerm_virtual_network_peering" "vnets-peering-3-1" {
#  name                      = "peer-vnet3-to-vnet1"
#  resource_group_name       = azurerm_resource_group.azurerg.name
#  virtual_network_name      = azurerm_virtual_network.aks-vnets[2].name
#  remote_virtual_network_id = azurerm_virtual_network.aks-vnets[0].id
#}

#resource "azurerm_virtual_network_peering" "vnets-peering-2-3" {
#  name                      = "peer-vnet2-to-vnet3"
#  resource_group_name       = azurerm_resource_group.azurerg.name
#  virtual_network_name      = azurerm_virtual_network.aks-vnets[1].name
#  remote_virtual_network_id = azurerm_virtual_network.aks-vnets[2].id
#}

#resource "azurerm_virtual_network_peering" "vnets-peering-3-2" {
#  name                      = "peer-vnet3-to-vnet2"
#  resource_group_name       = azurerm_resource_group.azurerg.name
#  virtual_network_name      = azurerm_virtual_network.aks-vnets[2].name
#  remote_virtual_network_id = azurerm_virtual_network.aks-vnets[1].id
#}
