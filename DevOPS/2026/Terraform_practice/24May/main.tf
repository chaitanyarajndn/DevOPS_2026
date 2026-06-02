resource "azurerm_resource_group" "RGA" {
  for_each = var.rg_name
  name     = each.value.name
  location = each.value.location
}

resource "azurerm_storage_account" "TESTSTG" {
  for_each = var.strac
  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.RGA[each.key].name
  location                 = azurerm_resource_group.RGA[each.key].location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

}
