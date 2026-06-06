resource "azurerm_resource_group" "RG" {
  name     = var.rg
  location = var.lc
}


resource "azurerm_virtual_network" "VN" {
  name                = var.vn
  location            = var.lc
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = ["10.46.0.0/18"]

}

resource "azurerm_subnet" "SBN" {
  name                 = "testsbn"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.VN.name
  address_prefixes     = ["10.46.2.0/24"]
}


resource "azurerm_network_security_group" "NSG" {
  name                = "abcnsg"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "PIP" {
  name                = "publiciptest"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  allocation_method   = "static"
}

resource "azurerm_network_interface" "NIC" {
  name                = "testnic"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SBN.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.PIP.id
  }
}

resource "azurerm_subnet_network_security_group_association" "NSG_ASSOC" {
  subnet_id                 = azurerm_subnet.SBN.id
  network_security_group_id = azurerm_network_security_group.NSG.id
}




resource "azurerm_linux_virtual_machine" "VM" {
  name                            = var.vm
  resource_group_name             = azurerm_resource_group.RG.name
  location                        = azurerm_resource_group.RG.location
  size                            = "Standard_D2s_v3"
  admin_username                  = "testadmin"
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



