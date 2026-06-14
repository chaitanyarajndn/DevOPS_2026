resource "azurerm_subnet" "SBN" {
  for_each             = var.sbn
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.RG[each.value.resource_group_name].name
  virtual_network_name = azurerm_virtual_network.VN[each.value.virtual_network_name].name
  address_prefixes     = [each.value.address_prefixes]

}