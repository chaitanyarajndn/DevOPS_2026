pip = {
  pipa = {
    name                = "bastionip"
    resource_group_name = "rga"
    location            = "rga"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

  pipb = {
    name                = "frontendip"
    resource_group_name = "rga"
    location            = "rga"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}


bas = {
  basa = {
    name                 = "AZBastion"
    location             = "rga"
    resource_group_name  = "rga"
    basname              = "private-connection"
    subnet_id            = "sbna"
    public_ip_address_id = "pipa"
  }
}