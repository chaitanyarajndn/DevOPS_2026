resource "azurerm_network_security_group" "NSG" {
  for_each            = var.nsg
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.location].location
  resource_group_name = azurerm_resource_group.RG[each.value.resource_group_name].name

}

resource "azurerm_network_security_rule" "NSR" {
  for_each                    = var.nsr
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.RG[each.value.resource_group_name].name
  network_security_group_name = azurerm_network_security_group.NSG[each.value.network_security_group_name].name
}

resource "azurerm_subnet_network_security_group_association" "NSGAS" {
  for_each                  = var.nsgas
  subnet_id                 = azurerm_subnet.SBN[each.value.subnet_id].id
  network_security_group_id = azurerm_network_security_group.NSG[each.value.network_security_group_id].id
}

