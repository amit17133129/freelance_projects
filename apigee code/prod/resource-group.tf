

# Terraform Resource for creating Azure Resource Group.
resource "azurerm_resource_group" "azurerg" {
  for_each = var.aks_clusters
  name     = "${var.environment == "prod" ? "prod" : "dev"}-${each.key}"
  location = each.key #var.resource_group_location
}
