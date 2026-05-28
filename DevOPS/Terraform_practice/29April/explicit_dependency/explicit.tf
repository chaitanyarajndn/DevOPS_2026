terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "82f101c4-2e23-47de-97c7-2d8387f73355"
}

resource "azurerm_resource_group" "RG2" {
  name     = "rg_test_explicit"
  location = "West Europe"
}

resource "azurerm_storage_account" "STG-2" {
  depends_on               = [azurerm_resource_group.RG2]
  name                     = "explicittest007"
  resource_group_name      = "rg_test_explicit"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}