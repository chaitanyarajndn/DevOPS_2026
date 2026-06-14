ni = {
  nia = {
    name                          = "frontendNI"
    location                      = "rga"
    resource_group_name           = "rga"
    niname                        = "frontendinternal"
    subnet_id                     = "sbnb"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "pipb"
  }

  nib = {
    name                          = "backendNI"
    location                      = "rga"
    resource_group_name           = "rga"
    niname                        = "backendinternal"
    subnet_id                     = "sbnc"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = null
  }

  nic = {
    name                          = "databaseNI"
    location                      = "rga"
    resource_group_name           = "rga"
    niname                        = "databaseinternal"
    subnet_id                     = "sbnd"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = null
  }

}

linxvm = {
  linxvma = {
    name                  = "FrontendVM"
    resource_group_name   = "rga"
    location              = "rga"
    size                  = "Standard_D2s_v3"
    admin_username        = "frontendadmin"
    admin_password        = "Xolouser@8674"
    network_interface_ids = "nia"
  }

  linxvmb = {
    name                  = "DatabaseVM"
    resource_group_name   = "rga"
    location              = "rga"
    size                  = "Standard_D2s_v3"
    admin_username        = "databaseadmin"
    admin_password        = "Xolouser@8674"
    network_interface_ids = "nic"
  }

}

winvm = {
  winvma = {
    name                  = "BackendVM"
    resource_group_name   = "rga"
    location              = "rga"
    size                  = "Standard_D2s_v3"
    admin_username        = "backendadmin"
    admin_password        = "Xolouser@8674"
    network_interface_ids = "nib"

  }
}