resource "azurerm_network_interface_security_group_association" "NICAS" {
  for_each = var.nicas
  network_interface_id      = var.nic_ID[each.value.network_interface_id]
  network_security_group_id = var.nsg_ID[each.value.network_security_group_id]
}


