resource "azurerm_bastion_host" "BAS" {
    for_each = var.bast
    name                = each.value.name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.ipname
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip
  }

}

