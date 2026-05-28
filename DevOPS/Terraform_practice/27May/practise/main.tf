# Create a resource group
resource "azurerm_resource_group" "RGdev" {
  for_each = var.x
  name     = each.key
  location = each.value

}

resource "azurerm_storage_account" "STRAC" {
  depends_on = [ azurerm_resource_group.RGdev ]
  for_each = var.y
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

}



