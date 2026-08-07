output "virtual_netowrk_id" {
    value = {
        for key, vn in azurerm_virtual_network.VN :
        key => vn.id
    }
}