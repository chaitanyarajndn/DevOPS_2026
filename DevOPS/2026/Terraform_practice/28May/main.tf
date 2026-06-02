resource "azurerm_resource_group" "RGtst" {
  for_each = var.rg
  name     = each.value.name
  location = each.value.location
}


resource "azurerm_virtual_network" "vn" {
  for_each = var.vn
  name                = each.value.name
  location            = each.value.location
  resource_group_name = azurerm_resource_group.RGtst[each.value.resource_group_name].name
  address_space       = each.value.address_space


}

resource "azurerm_subnet" "sbnet" {
    for_each = var.sb
    name      = each.value.name
    resource_group_name  = azurerm_resource_group.RGtst[each.value.resource_group_name].name
    virtual_network_name = azurerm_virtual_network.vn[each.value.virtual_network_name].name
    address_prefixes = each.value.address_prefixes

}



