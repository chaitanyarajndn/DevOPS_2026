nsg = {
  nsga = {
    name                = "nsgfrontend"
    location            = "rga"
    resource_group_name = "rga"
  }

  nsgb = {
    name                = "nsgbackend"
    location            = "rga"
    resource_group_name = "rga"
  }

  nsgc = {
    name                = "nsgdatabase"
    location            = "rga"
    resource_group_name = "rga"
  }

}

nsr = {
  nsra = {
    name                        = "frontendssh"
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
    name                        = "frontendhttp"
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
    name                        = "frontendhttps"
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

nsgas = {
  nsgas1 = {
    subnet_id                 = "sbnb"
    network_security_group_id = "nsga"
  }

  nsgas2 = {
    subnet_id                 = "sbnc"
    network_security_group_id = "nsgb"
  }

  nsgas3 = {
    subnet_id                 = "sbnd"
    network_security_group_id = "nsgc"
  }

}









