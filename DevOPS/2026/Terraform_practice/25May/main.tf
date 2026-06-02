resource "azurerm_resource_group" "testRG" {
  for_each = var.rgn
  name     = each.value.name
  location = each.value.location
  managed_by = each.value.managed_by
}

resource "azurerm_storage_account" "testSTG" {
  for_each = var.rgn
  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.testRG[each.key].name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
 
 }