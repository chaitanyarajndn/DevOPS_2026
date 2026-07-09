resource "azurerm_lb" "LINXLB" {
  for_each            = var.lb
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  frontend_ip_configuration {
    name                 = each.value.ipname
    public_ip_address_id = var.lbpip_ID
  }
}













