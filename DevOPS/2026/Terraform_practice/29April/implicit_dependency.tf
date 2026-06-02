resource "azurerm_resource_group" "RG1" {
  name     = "RG_TEST_A"
  location = "West Europe"
}

resource "azurerm_storage_account" "STG-1" {
  name                     = "iam001"
  resource_group_name      = azurerm_resource_group.RG1.name
  location                 = azurerm_resource_group.RG1.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}
