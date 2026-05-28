resource "azurerm_resource_group" "rgn" {

  name     = var.rg
  location = var.lc

}


# resource "azurerm_storage_account" "stg" {

#   name                     = var.str
#   resource_group_name      = azurerm_resource_group.rgn.name
#   location                 = azurerm_resource_group.rgn.location
#   account_tier             = "Standard"
#   account_replication_type = var.rep

# }






