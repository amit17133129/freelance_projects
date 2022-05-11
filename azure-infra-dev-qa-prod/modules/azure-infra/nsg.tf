resource "azurerm_network_security_group" "nsg" {
  name                = "${var.env}-${var.nsg_name}"
  location            = azurerm_resource_group.resource-group.location
  resource_group_name = azurerm_resource_group.resource-group.name

  security_rule {
    name                       = local.security_rule.name
    priority                   = local.security_rule.priority
    direction                  = local.security_rule.direction
    access                     = local.security_rule.access
    protocol                   = local.security_rule.protocol
    source_port_range          = local.security_rule.source_port_range
    destination_port_range     = local.security_rule.destination_port_range
    source_address_prefix      = local.security_rule.source_address_prefix
    destination_address_prefix = local.security_rule.destination_address_prefix
  }
    tags = {
    "Name" = "${var.env}"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
    count = length(var.private_subnet_names)
  subnet_id                 = azurerm_subnet.private_subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

