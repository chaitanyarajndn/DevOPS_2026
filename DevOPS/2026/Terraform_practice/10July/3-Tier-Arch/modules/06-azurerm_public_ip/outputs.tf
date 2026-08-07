output "publicip_ID" {
    value = {
        for key, pip in azurerm_public_ip.PIP :
        key => pip.id
    }
}