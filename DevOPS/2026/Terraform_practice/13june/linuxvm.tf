resource "azurerm_linux_virtual_machine" "example" {
  for_each                        = var.linxvm
  name                            = each.value.name
  resource_group_name             = azurerm_resource_group.RG[each.value.resource_group_name].name
  location                        = azurerm_resource_group.RG[each.value.location].location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.NI[each.value.network_interface_ids].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}