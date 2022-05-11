terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "dev-rg"
    storage_account_name = "zzzxxxxxxxxx"
    container_name       = "terraform"
    key                  = "dev.terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
}
