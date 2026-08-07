resource "azurerm_virtual_network_peering" "VPEER" {
  for_each = var.vpeer
  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = var.vn_ID[each.value.virtual_network_name]
  remote_virtual_network_id = var.vn_ID[each.value.remote_virtual_network_id]
}




