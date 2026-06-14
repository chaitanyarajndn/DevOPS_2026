resource "azurerm_virtual_network_peering" "PEER" {
  for_each                  = var.peer
  name                      = each.value.name
  resource_group_name       = azurerm_resource_group.RG[each.value.resource_group_name].name
  virtual_network_name      = azurerm_virtual_network.VN[each.value.virtual_network_name].name
  remote_virtual_network_id = azurerm_virtual_network.VN[each.value.remote_virtual_network_id].id
}
