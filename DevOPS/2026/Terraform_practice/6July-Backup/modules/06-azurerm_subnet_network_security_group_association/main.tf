resource "azurerm_subnet_network_security_group_association" "NSGASC" {
  for_each = {
    for key, value in var.subnet_id :
    key => value
    if key != "bastionsbnet"
  }
  subnet_id                 = each.value
  network_security_group_id = var.nsg_id
}
