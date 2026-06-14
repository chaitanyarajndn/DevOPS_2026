resource "azurerm_virtual_network" "VN" {
  for_each            = var.vn
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.location].location
  resource_group_name = azurerm_resource_group.RG[each.value.resource_group_name].name
  address_space       = [each.value.address_space]

}