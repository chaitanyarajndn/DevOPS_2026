output "network_security_group_ID" {
  value = {
  for key, nsg in azurerm_network_security_group.NSG :
  key => nsg.id
  }
}