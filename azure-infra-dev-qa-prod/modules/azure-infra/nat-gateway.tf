resource "azurerm_nat_gateway" "nat" {
    count = length(var.nat_gateway)
    name                = "${var.env}-${var.nat_gateway[count.index]}"
    location            = azurerm_resource_group.resource-group.location
    resource_group_name = azurerm_resource_group.resource-group.name
      tags = {
    "Name" = "${var.env}"
  }
}

resource "azurerm_subnet_nat_gateway_association" "nat_association" {
    count = length(var.public_subnet_names)
  subnet_id      = azurerm_subnet.public_subnet[count.index].id
  nat_gateway_id = azurerm_nat_gateway.nat[count.index].id
}