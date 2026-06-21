rg = {

  rga = {
    name     = "intelrg"
    location = "westus2"
  }
}

vn = {

  vna = {
    name          = "VNmgmt"
    rg_name       = "rga"
    address_space = ["10.57.0.0/20"]
  }

  vnb = {
    name          = "VNapp"
    rg_name       = "rga"
    address_space = ["10.57.16.0/20"]
  }

}

sbn = {

  sbna = {
    name             = "AzureBastionSubnet"
    rg_name          = "rga"
    vn_name          = "vna"
    address_prefixes = ["10.57.0.0/24"]
  }

  sbnb = {
    name             = "linx1sbn"
    rg_name          = "rga"
    vn_name          = "vnb"
    address_prefixes = ["10.57.16.0/24"]
  }

  sbnc = {
    name             = "linx2sbn"
    rg_name          = "rga"
    vn_name          = "vnb"
    address_prefixes = ["10.57.17.0/24"]
  }

}


nsg = {

  nsga = {
    name    = "linx1nsg"
    rg_name = "rga"

    security_rules = [
      {
        srname                     = "allowSSH"
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
        srname                     = "allowHTTP"
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

  nsgb = {
    name    = "linx2nsg"
    rg_name = "rga"

    security_rules = [
      {
        srname                     = "allowSSH"
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
        srname                     = "allowHTTP"
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


nsgas = {

  nsgas1 = {
    subnet_id = "sbnb"
    nsg_id    = "nsga"
  }


  nsgas2 = {
    subnet_id = "sbnc"
    nsg_id    = "nsgb"
  }

}


pip = {
  pipa = {
    name              = "BastionPIP"
    rg_name           = "rga"
    sku               = "Standard"
    allocation_method = "Static"
  }

  pipb = {
    name              = "LoadBalancerPIP"
    rg_name           = "rga"
    sku               = "Standard"
    allocation_method = "Static"
  }

}


bas = {
  basa = {
    name      = "LinxBastion"
    rg_name   = "rga"
    confname  = "BastionConfiguration"
    subnet_id = "sbna"
    pip_id    = "pipa"
  }

}


peer = {
  peera = {
    name    = "mgmt-to-app"
    rg_name = "rga"
    vn_name = "vna"
    rvn_id  = "vnb"
  }

  peerb = {
    name    = "app-to-mgmt"
    rg_name = "rga"
    vn_name = "vnb"
    rvn_id  = "vna"
  }
}


nic = {
  nica = {
    name      = "linx1nic"
    rg_name   = "rga"
    subnet_id = "sbnb"
    nic_name  = "Linx1Internal"
  }

  nicb = {
    name      = "linx2nic"
    rg_name   = "rga"
    subnet_id = "sbnc"
    nic_name  = "Linx2Internal"
  }
}


nicas = {
  nicas1 = {
    nic_id = "nica"
    nsg_id = "nsga"
  }

  nicas2 = {
    nic_id = "nicb"
    nsg_id = "nsgb"
  }

}


linxvm = {
  linxvm1 = {
    name           = "LinxVM1"
    rg_name        = "rga"
    size           = "Standard_B2als_v2"
    admin_username = "linx1admin"
    admin_password = "Xolouser@8674"
    nic_ids        = "nica"
  }

  linxvm2 = {
    name           = "LinxVM2"
    rg_name        = "rga"
    size           = "Standard_B2als_v2"
    admin_username = "linx2admin"
    admin_password = "Xolouser@8674"
    nic_ids        = "nicb"
  }
}


lb = {
  lba = {
    name    = "LinxLoadBalancer"
    rg_name = "rga"
    pip_id  = "pipb"
  }
}

bpool = {
  bpoola = {
    lb_id = "lba"
    name  = "BackEndAddressPool"
  }
}


lbprobe = {
  lbprobe1 = {
    lb_id               = "lba"
    name                = "HealthProbe"
    protocol            = "Http"
    port                = 80
    request_path        = "/"
    interval_in_seconds = 5
  }
}


lbrule = {
  lbrule1 = {
    lb_id                          = "lba"
    name                           = "LBRule"
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "FrontendIP"
    backend_address_pool_ids       = "bpoola"
    probe_id                       = "lbprobe1"
  }
}


nibkasc = {
  nibkasc1 = {
    nic_id          = "nica"
    ip_conf_name    = "Linx1Internal"
    backend_pool_id = "bpoola"
  }

  nibkasc2 = {
    nic_id          = "nicb"
    ip_conf_name    = "Linx2Internal"
    backend_pool_id = "bpoola"
  }
}













