terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.65.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "594ca230-6fcf-4aa3-81ac-5e4d3ec2027c"
}