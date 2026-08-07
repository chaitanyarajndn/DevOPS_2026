resource "azurerm_bastion_host" "BAS" {
  for_each = var.bas
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.ipname
    subnet_id            = var.subnet_ID
    public_ip_address_id = var.pip_ID
  }
}

