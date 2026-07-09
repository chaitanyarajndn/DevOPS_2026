output "network_interface_ID" {
    value = {
        for key, nic in azurerm_network_interface.NIC :
        key => nic.id
    }
}