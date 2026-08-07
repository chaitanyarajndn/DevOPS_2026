resource "azurerm_virtual_network" "VN" {
  for_each = var.vn
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = [each.value.address_space]
}



