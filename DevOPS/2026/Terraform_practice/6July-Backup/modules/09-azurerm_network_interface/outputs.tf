output "network_interface_ID" {
    value = {
        for nic in azurerm_network_interface.NIC :
        nic.name => nic.id
    }
}