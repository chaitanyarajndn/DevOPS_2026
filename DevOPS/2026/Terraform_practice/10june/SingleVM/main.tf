resource "azurerm_resource_group" "RG" {
  name     = var.rg
  location = var.lc
}

resource "azurerm_virtual_network" "VN" {
  name                = var.vn
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = [var.vn_add]

}

resource "azurerm_subnet" "SBN" {
  name                 = var.sbn
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.VN.name
  address_prefixes     = [var.sbn_add]
}


resource "azurerm_public_ip" "PIP" {
  name                = var.pip
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "NSG" {
  name                = var.nsg
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

}

resource "azurerm_network_security_rule" "NSR" {
  name                        = var.nsr
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.RG.name
  network_security_group_name = azurerm_network_security_group.NSG.name
}

resource "azurerm_subnet_network_security_group_association" "SBN_NSG_ASS" {
  subnet_id                 = azurerm_subnet.SBN.id
  network_security_group_id = azurerm_network_security_group.NSG.id
}


resource "azurerm_network_interface" "NIC" {
  name                = var.nic
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SBN.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.PIP.id
  }
}


resource "azurerm_linux_virtual_machine" "LINUX-VM" {
  name                            = var.vm
  resource_group_name             = azurerm_resource_group.RG.name
  location                        = azurerm_resource_group.RG.location
  size                            = "Standard_D2s_v3"
  admin_username                  = "adminuser"
  admin_password                  = "Xolouser@8674"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.NIC.id]

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







