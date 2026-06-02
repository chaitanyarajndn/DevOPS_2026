resource "azurerm_resource_group" "RGZ" {
  for_each = var.x
  name     = each.key
  location = each.value
}



resource "azurerm_storage_account" "STRAC" {
  depends_on = [ azurerm_resource_group.RGZ ]
  for_each = var.y
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

}


# resource "azurerm_virtual_network" "VNtest" {
#   for_each = var.z
#   name                = each.value.name
#   location            = azurerm_resource_group.RGZ[each.value.location].location
#   resource_group_name = azurerm_resource_group.RGZ[each.value.resource_group_name].name
#   address_space       = each.value.address_space
#   dns_servers         = each.value.dns_servers

#   subnet {
#     name             = each.value.sbname1
#     address_prefixes = each.value.address_prefixes1
#   }

#   subnet {
#     name             = each.value.sbname2
#     address_prefixes = each.value.address_prefixes2
#   }

# }



