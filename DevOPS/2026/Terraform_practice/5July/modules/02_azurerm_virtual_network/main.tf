resource "azurerm_virtual_network" "VN" {
  name                = var.vn
  location            = var.lc
  resource_group_name = var.rg
  address_space       = var.ipadd

}