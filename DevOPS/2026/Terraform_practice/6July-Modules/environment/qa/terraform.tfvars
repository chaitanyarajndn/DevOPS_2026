rg_map = {
  rga = {
    name     = "rg-web"
    location = "central india"
  }
}



vn_map = {
  vna = {
    name                = "vnet-web"
    resource_group_name = "rg-web"
    location            = "central india"
    address_space       = ["10.77.0.0/20"]
  }
}



sbn_map = {
  bastionsbnet = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-web"
    virtual_network_name = "vnet-web"
    address_prefixes     = ["10.77.0.0/24"]
  }

  web1sbnet = {
    name                 = "snet-web01"
    resource_group_name  = "rg-web"
    virtual_network_name = "vnet-web"
    address_prefixes     = ["10.77.1.0/24"]
  }

  web2sbnet = {
    name                 = "snet-web02"
    resource_group_name  = "rg-web"
    virtual_network_name = "vnet-web"
    address_prefixes     = ["10.77.2.0/24"]
  }
}


nsg_map = {
  webnsg = {
    name                = "nsg-web"
    location            = "central india"
    resource_group_name = "rg-web"
  }

}


nsr_map = {
  nsra = {
    name                        = "AllowSSH"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = "rg-web"
    network_security_group_name = "nsg-web"
  }

  nsrb = {
    name                        = "AllowHTTP"
    priority                    = 110
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = "rg-web"
    network_security_group_name = "nsg-web"
  }

}

pip_map = {
  loadbalancerpip = {
    name                = "pip-lb"
    location            = "central india"
    resource_group_name = "rg-web"
    allocation_method   = "Static"
  }

  pipbastion = {
    name                = "pip-bastion"
    resource_group_name = "rg-web"
    location            = "central india"
    allocation_method   = "Static"
  }

}

bast_map = {
  basta = {
    name                = "bas-web"
    location            = "central india"
    resource_group_name = "rg-web"
    ipname              = "defaultip"
  }
}



nic_map = {
  web1nic = {
    name                          = "nic-web01"
    location                      = "central india"
    resource_group_name           = "rg-web"
    ipname                        = "default-confweb1"
    subnet_id                     = "web1sbnet"
    private_ip_address_allocation = "Dynamic"
  }

  web2nic = {
    name                          = "nic-web02"
    location                      = "central india"
    resource_group_name           = "rg-web"
    ipname                        = "default-confweb2"
    subnet_id                     = "web1sbnet"
    private_ip_address_allocation = "Dynamic"
  }
}



linxvm_map = {
  linxvm1 = {
    name                  = "web1vm"
    resource_group_name   = "rg-web"
    location              = "central india"
    size                  = "Standard_D2s_v3"
    admin_username        = "adminuser"
    admin_password        = "Xolouser@8674"
    network_interface_ids = "web1nic"
  }

  linxvm2 = {
    name                  = "web2vm"
    resource_group_name   = "rg-web"
    location              = "central india"
    size                  = "Standard_D2s_v3"
    admin_username        = "adminuser"
    admin_password        = "Xolouser@8674"
    network_interface_ids = "web2nic"
  }

}



lb_map = {
  linxlb = {
    name                 = "LinxLoadBalancer"
    location             = "central india"
    resource_group_name  = "rg-web"
    sku                  = "Standard"
    ipname               = "LinxIP1"
    public_ip_address_id = "loadbalancerpip"
  }
}


bpool_map = {
  backendpool = {
    name            = "LinxBackendPool"
  }

}


lbprobe_map = {
  healthprobe = {
    name                = "HealthProbe"
    protocol            = "Http"
    port                = 80
    request_path        = "/"
    interval_in_seconds = 5
  }
}


lbrule_map = {
  lbrule1 = {
    name                           = "Linx-LBRule"
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "LinxIP1"
  }

}


nibkasc_map = {
  nicbkpoolasc = {
    ip_conf_name    = "default-confweb1"
    network_interface_ids = "web1nic"
  }
  nibkasc2 = {
    ip_conf_name    = "default-confweb2"
    network_interface_ids = "web2nic"
  }
}
























