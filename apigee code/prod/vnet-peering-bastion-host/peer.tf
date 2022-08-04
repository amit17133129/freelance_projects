
resource "azurerm_virtual_network_peering" "vnets-peering-1-2" {
  name                      = var.peering_connection_name_1
  resource_group_name       = data.terraform_remote_state.backend.outputs.rg_name[0]
  virtual_network_name      = data.terraform_remote_state.backend.outputs.vnet_names[0]
  remote_virtual_network_id = data.terraform_remote_state.backend.outputs.vnet_ids[1]
}

resource "azurerm_virtual_network_peering" "vnets-peering-2-1" {
  name                      = var.peering_connection_name_2
  resource_group_name       = data.terraform_remote_state.backend.outputs.rg_name[1]
  virtual_network_name      = data.terraform_remote_state.backend.outputs.vnet_names[1]
  remote_virtual_network_id = data.terraform_remote_state.backend.outputs.vnet_ids[0]
}