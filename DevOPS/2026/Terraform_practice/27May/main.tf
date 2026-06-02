# Create a resource group
resource "azurerm_resource_group" "RGdev" {
  for_each = var.rg
  name     = each.key
  location = each.value

}

resource "azurerm_virtual_network" "vntry" {
  for_each = var.vn
  name                = each.value.name
  resource_group_name = azurerm_resource_group.RGdev[each.value.resource_group_name].name
  location            = azurerm_resource_group.RGdev[each.value.resource_group_name].location
  address_space       = each.value.address_space 

subnet {
    name             = each.value.sbname
    address_prefixes = each.value.sbaddress_prefixes
}

}

# resource "azurerm_storage_account" "STRAC" {
#   name                     = "testdev08"
#   resource_group_name      = azurerm_resource_group.RGdev.name
#   location                 = azurerm_resource_group.RGdev.location
#   account_tier             = "standard"
#   account_replication_type = "LRS"

# }
