output "nic_ids" {
  value = {
    for key, nic in azurerm_network_interface.NIC :
    key => nic.id
  }
}

