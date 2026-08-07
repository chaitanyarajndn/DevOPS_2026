module "resource_group" {
  source = "../../modules/01-azurerm_resource_group"
  rg     = var.rg_map
}



module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../modules/02-azurerm_virtual_network"
  vn         = var.vn_map
}



module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../../modules/03-azurerm_subnet"
  sbn        = var.sbn_map
}



module "network_security_group" {
  depends_on = [module.resource_group]
  source     = "../../modules/04-azurerm_network_security_group"
  nsg        = var.nsg_map
}



module "network_security_rule" {
  depends_on = [module.network_security_group]
  source     = "../../modules/05-azurerm_network_security_rule"
  nsr        = var.nsr_map
}



module "subnet_network_security_group_association" {
  depends_on = [module.subnet, module.network_security_group]
  source     = "../../modules/06-azurerm_subnet_network_security_group_association"
  subnet_id  = module.subnet.subnet_id
  nsg_id     = module.network_security_group.network_security_group_ID["webnsg"]

}



module "public_IP" {
  depends_on = [module.resource_group]
  source     = "../../modules/07-azurerm_public_ip"
  pip        = var.pip_map
}



module "bastion" {
  depends_on = [module.subnet, module.network_security_group]
  source     = "../../modules/08-azurerm_bastion_host"
  bast       = var.bast_map
  subnet_id  = module.subnet.subnet_id["bastionsbnet"]
  public_ip  = module.public_IP.public_ip_ID["pipbastion"]
}



module "network_interface" {
  depends_on = [ module.subnet ]
  source = "../../modules/09-azurerm_network_interface"
  nic = var.nic_map
  subnet_ID = module.subnet.subnet_id

}


module "virtual_machines" {
  depends_on = [ module.network_interface, module.subnet, module.network_security_group, module.public_IP, module.subnet_network_security_group_association, module.network_security_rule ]
  source = "../../modules/10-azurerm_linux_virtual_machine"
  linxvm = var.linxvm_map
  nic_ID = module.network_interface.network_interface_ID
}



module "load_balancer" {
  depends_on = [ module.public_IP, module.network_interface ]
  source = "../../modules/11-azurerm_lb"
  lb = var.lb_map
  lbpip_ID = module.public_IP.public_ip_ID["loadbalancerpip"]
}



module "lb_backend_pool" {
  depends_on = [ module.subnet ]
  source = "../../modules/12-azurerm_lb_backend_address_pool"
  bpool = var.bpool_map
  lb_ID = module.load_balancer.load_balancer_id["linxlb"]
}



module "lb_health_probe" {
  depends_on = [ module.load_balancer ]
  source = "../../modules/13-azurerm_lb_probe"
  lbprobe = var.lbprobe_map
  lb_ID = module.load_balancer.load_balancer_id["linxlb"]
}


module "load_balancer_rule" {
  depends_on = [ module.load_balancer, module.lb_backend_pool, module.lb_health_probe ]
  source = "../../modules/14-azurerm_lb_rule"
  lbrule = var.lbrule_map
  lb_ID = module.load_balancer.load_balancer_id["linxlb"]
  probe_ID = module.lb_health_probe.lb_health_probe_id["healthprobe"]
  bkp_ID = module.lb_backend_pool.lb_backend_pool_id["backendpool"]
}


module "network_interface_backend_pool_association" {
  depends_on = [ module.lb_backend_pool, module.network_interface ]
  source = "../../modules/15-azurerm_network_interface_backend_address_pool_association"
  nibkasc = var.nibkasc_map
  nic_ID = module.network_interface.network_interface_ID
  bkp_ID = module.lb_backend_pool.lb_backend_pool_id["backendpool"]
  
}








