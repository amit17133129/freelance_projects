terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}
# provider "azurerm" {
#   subscription_id = "34060c8f-b4c7-48c3-8297-f90d038bbead"
# #   client_id       = "xxxxxxxxxxxxxxxxxx"
# #   client_secret   = "xxxxxxxxxxxxxxxxxx"
#   tenant_id       = "7fa7d4ff-bf19-464b-89a6-a132b269d68c"
#   features {}
# }