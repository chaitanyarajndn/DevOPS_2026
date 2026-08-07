rg_map = {
  rga = {
    name     = "nova-rg"
    location = "east us"
  }
}



vn_map = {
  vn-mgmt = {
    name                = "nova-mgmt-vnet"
    location            = "east us"
    resource_group_name = "nova-rg"
    address_space       = "10.34.41.0/26"
  }

  vn-app = {
    name                = "nova-app-vnet"
    location            = "east us"
    resource_group_name = "nova-rg"
    address_space       = "10.34.41.64/26"
  }
}



sbn_map = {
  bastion-sbn = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "nova-rg"
    virtual_network_name = "nova-mgmt-vnet"
    address_prefixes     = "10.34.41.0/27"
  }

  frontend-sbn = {
    name                 = "frontend-snet"
    resource_group_name  = "nova-rg"
    virtual_network_name = "nova-app-vnet"
    address_prefixes     = "10.34.41.64/28"
  }

  backend-sbn = {
    name                 = "backend-snet"
    resource_group_name  = "nova-rg"
    virtual_network_name = "nova-app-vnet"
    address_prefixes     = "10.34.41.80/28"
  }

  database-sbn = {
    name                 = "database-snet"
    resource_group_name  = "nova-rg"
    virtual_network_name = "nova-app-vnet"
    address_prefixes     = "10.34.41.96/28"
  }

}


nsg_map = {
  fend-nsg = {
    name                = "frontend-nsg"
    location            = "east us"
    resource_group_name = "nova-rg"
    nsrule = [
      {
        name                       = "AllowSSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "AllowHTTP"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"

      }
    ]
  }


  bkend-nsg = {
    name                = "backend-nsg"
    location            = "east us"
    resource_group_name = "nova-rg"
    nsrule = [
      {
        name                       = "AllowSSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "AllowHTTP"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"

      }
    ]
  }

}



nsgas_map = {
  fe_nsgas = {
    subnet_id                 = "frontend-sbn"
    network_security_group_id = "fend-nsg"
  }

  bk_nsgas = {
    subnet_id                 = "backend-sbn"
    network_security_group_id = "bkend-nsg"
  }

}



pip_map = {
  bastion-pip = {
    name                = "bastionpip"
    resource_group_name = "nova-rg"
    location            = "east us"
    sku                 = "Standard"
    allocation_method   = "Static"
  }

  fe-pip = {
    name                = "frontendpip"
    resource_group_name = "nova-rg"
    location            = "east us"
    sku                 = "Standard"
    allocation_method   = "Static"
  }

  bk-pip = {
    name                = "backendpip"
    resource_group_name = "nova-rg"
    location            = "east us"
    sku                 = "Standard"
    allocation_method   = "Static"
  }

}


bas_map = {
  bastion = {
    name                = "nova-bastion"
    location            = "east us"
    resource_group_name = "nova-rg"
    ipname              = "default-nova"
  }
}


vpeer_map = {
  mgt-to-app = {
    name                      = "mgmt-to-app-peer"
    resource_group_name       = "nova-rg"
    virtual_network_name      = "vn-mgmt"
    remote_virtual_network_id = "vn-app"
  }

  app-to-mgmt = {
    name                      = "app-to-mgmt-peer"
    resource_group_name       = "nova-rg"
    virtual_network_name      = "vn-app"
    remote_virtual_network_id = "vn-mgmt"
  }
}



nic_map = {
  fe-nic = {
    name                 = "frontend-nic"
    location             = "east us"
    resource_group_name  = "nova-rg"
    ipname               = "frontend-ip"
    subnet_id            = "frontend-sbn"
    public_ip_address_id = "fe-pip"
  }

  bk-nic = {
    name                 = "backend-nic"
    location             = "east us"
    resource_group_name  = "nova-rg"
    ipname               = "backend-ip"
    subnet_id            = "backend-sbn"
    public_ip_address_id = "bk-pip"
  }

  db-nic = {
    name                 = "database-nic"
    location             = "east us"
    resource_group_name  = "nova-rg"
    ipname               = "database-ip"
    subnet_id            = "database-sbn"
    public_ip_address_id = null
  }

}


nicas_map = {
  fe-nicas = {
    network_interface_id      = "fe-nic"
    network_security_group_id = "fend-nsg"
  }

  bk-nicas = {
    network_interface_id      = "bk-nic"
    network_security_group_id = "bkend-nsg"
  }

}



linxvm_map = {
  fe-vm = {
    name                  = "frontend-vm"
    resource_group_name   = "nova-rg"
    location              = "east us"
    size                  = "Standard_D2s_v3"
    admin_username        = "adminuser"
    admin_password        = "Xolouser@8674"
    network_interface_ids = "fe-nic"
  }

  bk-vm = {
    name                  = "backend-vm"
    resource_group_name   = "nova-rg"
    location              = "east us"
    size                  = "Standard_D2s_v3"
    admin_username        = "adminuser"
    admin_password        = "Xolouser@8674"
    network_interface_ids = "bk-nic"
  }

  db-vm = {
    name                  = "database-vm"
    resource_group_name   = "nova-rg"
    location              = "east us"
    size                  = "Standard_D2s_v3"
    admin_username        = "adminuser"
    admin_password        = "Xolouser@8674"
    network_interface_ids = "db-nic"
  }

}






