terraform {

  required_version = ">=0.15"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
backend "azurerm" { 
  subscription_id      = "enter_subscription_id"
  resource_group_name  = "enter_resource_group_name"
  storage_account_name = "enter_storage_account_name"
  container_name       = "enter_container_name"
  key                  = "terraform.tfstate"
}
}

data "terraform_remote_state" "backend" {
  backend = "azurerm"
  config = {
    subscription_id      = "enter_subscription_id"
    storage_account_name = "enter_storage_sccount_name"
    container_name       = "enter_container_name"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}