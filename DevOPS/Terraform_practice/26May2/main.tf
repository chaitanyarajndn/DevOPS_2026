resource "azurerm_resource_group" "RGtst4" {
  for_each = var.a
  name     = each.key
  location = each.value
}


resource "azurerm_storage_account" "TESTSTG" {
  depends_on = [ azurerm_resource_group.RGtst4 ]
  for_each                 = var.b
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}