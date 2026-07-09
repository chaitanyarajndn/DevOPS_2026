resource "azurerm_network_interface_backend_address_pool_association" "NICBackendAssc" {
  for_each                = var.nibkasc
  network_interface_id    = var.nic_ID[each.value.network_interface_ids]
  ip_configuration_name   = each.value.ip_conf_name
  backend_address_pool_id = var.bkp_ID
}
