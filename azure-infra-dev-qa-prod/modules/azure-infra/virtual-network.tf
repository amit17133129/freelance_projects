resource "azurerm_virtual_network" "vnet" {
  name                = "${var.env}-${var.vnet_name}"
  location            = azurerm_resource_group.resource-group.location
  resource_group_name = azurerm_resource_group.resource-group.name
  address_space       = var.address_space 
  dns_servers         = var.dns_servers 

  tags = {
    environment = "${var.env}"
  }
}


resource "azurerm_subnet" "public_subnet" {
  count                = length(var.public_subnet_names)
  name                 = "${var.env}-${var.public_subnet_names[count.index]}"
  resource_group_name  = azurerm_resource_group.resource-group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_address_prefix[count.index]]
}

resource "azurerm_subnet" "private_subnet" {
  count                = length(var.private_subnet_names)
  name                 = "${var.env}-${var.private_subnet_names[count.index]}"
  resource_group_name  = azurerm_resource_group.resource-group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_address_prefix[count.index]]
}
