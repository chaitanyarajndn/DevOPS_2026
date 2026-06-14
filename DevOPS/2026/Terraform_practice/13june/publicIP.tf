resource "azurerm_public_ip" "PIP" {
  for_each            = var.pip
  name                = each.value.name
  resource_group_name = azurerm_resource_group.RG[each.value.resource_group_name].name
  location            = azurerm_resource_group.RG[each.value.location].location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}


resource "azurerm_bastion_host" "BAS" {
  for_each            = var.bas
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.location].location
  resource_group_name = azurerm_resource_group.RG[each.value.resource_group_name].name

  ip_configuration {
    name                 = each.value.basname
    subnet_id            = azurerm_subnet.SBN[each.value.subnet_id].id
    public_ip_address_id = azurerm_public_ip.PIP[each.value.public_ip_address_id].id
  }

}