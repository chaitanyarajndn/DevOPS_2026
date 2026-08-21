output "resource_group_name" {
  description = "Azure Resource Group Name"
  value       = azurerm_resource_group.RG.name
}

output "resource_group_id" {
  description = "Azure Resource Group ID"
  value       = azurerm_resource_group.RG.id
}