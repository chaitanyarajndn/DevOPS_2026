rg = {

  rga = {
    name     = "intelrg"
    location = "Central India"
  }

}

vn = {

  vna = {
    name                = "VNET-MGMT"
    location            = "rga"
    resource_group_name = "rga"
    address_space       = "10.100.0.0/24"
  }

  vnb = {
    name                = "VNET-APP"
    location            = "rga"
    resource_group_name = "rga"
    address_space       = "10.100.1.0/24"
  }

}


sbn = {

  sbna = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rga"
    virtual_network_name = "vna"
    address_prefixes     = "10.100.0.0/26"
  }

  sbnb = {
    name                 = "snet-frontend"
    resource_group_name  = "rga"
    virtual_network_name = "vnb"
    address_prefixes     = "10.100.1.0/26"
  }

  sbnc = {
    name                 = "snet-backend"
    resource_group_name  = "rga"
    virtual_network_name = "vnb"
    address_prefixes     = "10.100.1.64/26"
  }

  sbnd = {
    name                 = "snet-database"
    resource_group_name  = "rga"
    virtual_network_name = "vnb"
    address_prefixes     = "10.100.1.128/26"
  }
}



nsg = {

  nsga = {
    name                = "nsg-frontend"
    location            = "rga"
    resource_group_name = "rga"

  }


  nsgb = {
    name                = "nsg-backend"
    location            = "rga"
    resource_group_name = "rga"

  }

  nsgc = {
    name                = "nsg-database"
    location            = "rga"
    resource_group_name = "rga"

  }

}


nsr = {

  nsra = {
    name                        = "frontend-ssh"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = "rga"
    network_security_group_name = "nsga"
  }


  nsrb = {
    name                        = "frontend-http"
    priority                    = 110
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = "rga"
    network_security_group_name = "nsga"
  }

  nsrc = {
    name                        = "frontend-https"
    priority                    = 120
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = "rga"
    network_security_group_name = "nsga"
  }

}


nsg_as = {

  nsg_asa = {
    subnet_id                 = "sbnb"
    network_security_group_id = "nsga"
  }

  nsg_asb = {
    subnet_id                 = "sbnc"
    network_security_group_id = "nsgb"
  }

  nsg_asc = {
    subnet_id                 = "sbnd"
    network_security_group_id = "nsgc"
  }

}


pip = {

  pipa = {

    name                = "Bastion_PIP"
    resource_group_name = "rga"
    location            = "rga"
    allocation_method   = "Static"
    sku                 = "Standard"

  }

  pipb = {

    name                = "Frontend_PIP"
    resource_group_name = "rga"
    location            = "rga"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}


bas = {
  basa = {
    name                 = "Azure-Bastion"
    location             = "rga"
    resource_group_name  = "rga"
    subnet_id            = "sbna"
    public_ip_address_id = "pipa"
    sku                  = "Standard"
  }
}


peer = {

  peera = {
    name                      = "mgmt-to-app"
    resource_group_name       = "rga"
    virtual_network_name      = "vna"
    remote_virtual_network_id = "vnb"
  }

  peerb = {
    name                      = "app-to-mgmt"
    resource_group_name       = "rga"
    virtual_network_name      = "vnb"
    remote_virtual_network_id = "vna"
  }
}


nic = {
  nica = {
    name                 = "Frontend-NIC"
    location             = "rga"
    resource_group_name  = "rga"
    subnet_id            = "sbnb"
    public_ip_address_id = "pipb"
  }

  nicb = {
    name                 = "Backend-NIC"
    location             = "rga"
    resource_group_name  = "rga"
    subnet_id            = "sbnc"
    public_ip_address_id = null
  }

  nicc = {
    name                = "Database-NIC"
    location            = "rga"
    resource_group_name = "rga"
    subnet_id           = "sbnd"

    public_ip_address_id = null
  }
}


linx_vm = {

  linx_vma = {
    name                            = "FrontendVM"
    resource_group_name             = "rga"
    location                        = "rga"
    size                            = "Standard_D2s_v3"
    admin_username                  = "adminuser"
    admin_password                  = "Xolouser@8674"
    disable_password_authentication = false
    network_interface_ids           = "nica"

  }

  linx_vmb = {
    name                            = "DatabaseVM"
    resource_group_name             = "rga"
    location                        = "rga"
    size                            = "Standard_D2s_v3"
    admin_username                  = "adminuser"
    admin_password                  = "Xolouser@8674"
    disable_password_authentication = false
    network_interface_ids           = "nicc"

  }

}


win_vm = {

  win_vma = {

    name                  = "BackendVM"
    resource_group_name   = "rga"
    location              = "rga"
    size                  = "Standard_D2s_v3"
    admin_username        = "adminuser"
    admin_password        = "Xolouser@8674"
    network_interface_ids = "nicb"

  }

}