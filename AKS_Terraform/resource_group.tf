resource "azurerm_resource_group" "k8s" {
  name     = var.resourcename
  location = var.location
}
