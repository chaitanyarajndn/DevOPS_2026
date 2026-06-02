resource "azurerm_resource_group" "RGtst" {
  for_each   = var.rg
  name       = each.value.name
  location   = each.value.location
  managed_by = each.value.managedby

}

resource "azurerm_storage_account" "testSTG" {
  for_each                 = var.str
  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.RGtst[each.value.resource_group_name].name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

}



