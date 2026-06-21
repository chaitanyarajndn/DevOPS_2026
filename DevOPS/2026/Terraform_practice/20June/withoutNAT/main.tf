resource "azurerm_resource_group" "RG" {
  for_each = var.rg
  name     = each.value.name
  location = each.value.location
}


resource "azurerm_virtual_network" "VN" {
  for_each            = var.vn
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.rg_name].location
  resource_group_name = azurerm_resource_group.RG[each.value.rg_name].name
  address_space       = each.value.address_space

}


resource "azurerm_subnet" "SBN" {
  for_each             = var.sbn
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.RG[each.value.rg_name].name
  virtual_network_name = azurerm_virtual_network.VN[each.value.vn_name].name
  address_prefixes     = each.value.address_prefixes

}


resource "azurerm_network_security_group" "NSG" {
  for_each            = var.nsg
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.rg_name].location
  resource_group_name = azurerm_resource_group.RG[each.value.rg_name].name


  dynamic "security_rule" {
    for_each = each.value.security_rules
    content {
      name                       = security_rule.value.srname
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}


resource "azurerm_subnet_network_security_group_association" "NSGSBN" {
  for_each                  = var.nsgas
  subnet_id                 = azurerm_subnet.SBN[each.value.subnet_id].id
  network_security_group_id = azurerm_network_security_group.NSG[each.value.nsg_id].id
}


resource "azurerm_public_ip" "PIP" {
  for_each            = var.pip
  name                = each.value.name
  resource_group_name = azurerm_resource_group.RG[each.value.rg_name].name
  location            = azurerm_resource_group.RG[each.value.rg_name].location
  sku                 = each.value.sku
  allocation_method   = each.value.allocation_method

}


resource "azurerm_bastion_host" "BAS" {
  for_each            = var.bas
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.rg_name].location
  resource_group_name = azurerm_resource_group.RG[each.value.rg_name].name

  ip_configuration {
    name                 = each.value.confname
    subnet_id            = azurerm_subnet.SBN[each.value.subnet_id].id
    public_ip_address_id = azurerm_public_ip.PIP[each.value.pip_id].id
  }
}



resource "azurerm_virtual_network_peering" "PEER" {
  for_each                  = var.peer
  name                      = each.value.name
  resource_group_name       = azurerm_resource_group.RG[each.value.rg_name].name
  virtual_network_name      = azurerm_virtual_network.VN[each.value.vn_name].name
  remote_virtual_network_id = azurerm_virtual_network.VN[each.value.rvn_id].id
}


resource "azurerm_network_interface" "NIC" {
  for_each            = var.nic
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.rg_name].location
  resource_group_name = azurerm_resource_group.RG[each.value.rg_name].name

  ip_configuration {
    name                          = each.value.nic_name
    subnet_id                     = azurerm_subnet.SBN[each.value.subnet_id].id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_network_interface_security_group_association" "NICNSGAS" {
  for_each                  = var.nicas
  network_interface_id      = azurerm_network_interface.NIC[each.value.nic_id].id
  network_security_group_id = azurerm_network_security_group.NSG[each.value.nsg_id].id
}


resource "azurerm_linux_virtual_machine" "LINUXVM" {
  for_each                        = var.linxvm
  name                            = each.value.name
  resource_group_name             = azurerm_resource_group.RG[each.value.rg_name].name
  location                        = azurerm_resource_group.RG[each.value.rg_name].location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.NIC[each.value.nic_ids].id]

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


resource "azurerm_lb" "LINXLB" {
  for_each            = var.lb
  name                = each.value.name
  location            = azurerm_resource_group.RG[each.value.rg_name].location
  resource_group_name = azurerm_resource_group.RG[each.value.rg_name].name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "FrontendIP"
    public_ip_address_id = azurerm_public_ip.PIP[each.value.pip_id].id
  }
}


resource "azurerm_lb_backend_address_pool" "BackendPool" {
  for_each        = var.bpool
  loadbalancer_id = azurerm_lb.LINXLB[each.value.lb_id].id
  name            = each.value.name
}


resource "azurerm_lb_probe" "HealthProbe" {
  for_each            = var.lbprobe
  loadbalancer_id     = azurerm_lb.LINXLB[each.value.lb_id].id
  name                = each.value.name
  protocol            = each.value.protocol
  port                = each.value.port
  request_path        = each.value.request_path
  interval_in_seconds = each.value.interval_in_seconds
}


resource "azurerm_lb_rule" "LBRule" {
  for_each                       = var.lbrule
  loadbalancer_id                = azurerm_lb.LINXLB[each.value.lb_id].id
  name                           = each.value.name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.BackendPool[each.value.backend_address_pool_ids].id]
  probe_id                       = azurerm_lb_probe.HealthProbe[each.value.probe_id].id
}



resource "azurerm_network_interface_backend_address_pool_association" "NICBackendAssc" {
  for_each                = var.nibkasc
  network_interface_id    = azurerm_network_interface.NIC[each.value.nic_id].id
  ip_configuration_name   = each.value.ip_conf_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackendPool[each.value.backend_pool_id].id
}












