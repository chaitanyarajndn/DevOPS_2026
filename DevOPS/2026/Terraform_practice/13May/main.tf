terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.72.0"
    }
  }

}

provider "azurerm" {
  features {}
  subscription_id = "638b610f-7d98-4629-830b-793735fba6c4"

}
