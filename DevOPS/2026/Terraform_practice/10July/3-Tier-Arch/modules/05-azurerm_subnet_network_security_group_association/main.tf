resource "azurerm_subnet_network_security_group_association" "NSGASC" {
  for_each = var.nsgas
  subnet_id                 = var.subnet_ID[each.value.subnet_id]
  network_security_group_id = var.nsg_ID[each.value.network_security_group_id]
}

