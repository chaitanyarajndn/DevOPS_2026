resource "azurerm_network_interface" "NI" {
  for_each            = var.ni
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.location].location
  resource_group_name = azurerm_resource_group.RG[each.value.resource_group_name].name

  ip_configuration {
    name                          = each.value.niname
    subnet_id                     = azurerm_subnet.SBN[each.value.subnet_id].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    public_ip_address_id          = each.value.public_ip_address_id != null ? azurerm_public_ip.PIP[each.value.public_ip_address_id].id : null

  }
}

