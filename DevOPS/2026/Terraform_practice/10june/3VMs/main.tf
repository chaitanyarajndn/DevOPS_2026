resource "azurerm_resource_group" "RG" {
  for_each = var.rg
  name     = each.value.name
  location = each.value.location
}

resource "azurerm_virtual_network" "VN" {
  for_each            = var.vn
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.location].location
  resource_group_name = azurerm_resource_group.RG[each.value.resource_group_name].name
  address_space       = [each.value.address_space]

}

resource "azurerm_subnet" "SBN" {
  for_each             = var.sbn
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.RG[each.value.resource_group_name].name
  virtual_network_name = azurerm_virtual_network.VN[each.value.virtual_network_name].name
  address_prefixes     = [each.value.address_prefixes]
}

resource "azurerm_network_security_group" "NSG" {
  for_each            = var.nsg
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.location].location
  resource_group_name = azurerm_resource_group.RG[each.value.resource_group_name].name

}

resource "azurerm_network_security_rule" "NSR" {
  for_each                    = var.nsr
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.RG[each.value.resource_group_name].name
  network_security_group_name = azurerm_network_security_group.NSG[each.value.network_security_group_name].name
}


resource "azurerm_subnet_network_security_group_association" "SBNNSGASS" {
  for_each                  = var.nsg_as
  subnet_id                 = azurerm_subnet.SBN[each.value.subnet_id].id
  network_security_group_id = azurerm_network_security_group.NSG[each.value.network_security_group_id].id
}


resource "azurerm_public_ip" "PIP" {
  for_each            = var.pip
  name                = each.value.name
  resource_group_name = azurerm_resource_group.RG[each.value.resource_group_name].name
  location            = azurerm_resource_group.RG[each.value.location].location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}


resource "azurerm_bastion_host" "BAS" {
  for_each            = var.bas
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.location].location
  resource_group_name = azurerm_resource_group.RG[each.value.resource_group_name].name
  sku                 = each.value.sku

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.SBN[each.value.subnet_id].id
    public_ip_address_id = azurerm_public_ip.PIP[each.value.public_ip_address_id].id
  }
}

resource "azurerm_virtual_network_peering" "VNPEER" {
  for_each                  = var.peer
  name                      = each.value.name
  resource_group_name       = azurerm_resource_group.RG[each.value.resource_group_name].name
  virtual_network_name      = azurerm_virtual_network.VN[each.value.virtual_network_name].name
  remote_virtual_network_id = azurerm_virtual_network.VN[each.value.remote_virtual_network_id].id
}


resource "azurerm_network_interface" "NIC" {
  for_each            = var.nic
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.location].location
  resource_group_name = azurerm_resource_group.RG[each.value.resource_group_name].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SBN[each.value.subnet_id].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = each.value.public_ip_address_id != null ? azurerm_public_ip.PIP[each.value.public_ip_address_id].id : null
  }
}


resource "azurerm_linux_virtual_machine" "LINUXVM" {
  for_each                        = var.linx_vm
  name                            = each.value.name
  resource_group_name             = azurerm_resource_group.RG[each.value.resource_group_name].name
  location                        = azurerm_resource_group.RG[each.value.location].location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.NIC[each.value.network_interface_ids].id]

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


resource "azurerm_windows_virtual_machine" "WINVM" {
  for_each              = var.win_vm
  name                  = each.value.name
  resource_group_name   = azurerm_resource_group.RG[each.value.resource_group_name].name
  location              = azurerm_resource_group.RG[each.value.location].location
  size                  = each.value.size
  admin_username        = each.value.admin_username
  admin_password        = each.value.admin_password
  network_interface_ids = [azurerm_network_interface.NIC[each.value.network_interface_ids].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-25h2-pro"
    version   = "latest"
  }
}


