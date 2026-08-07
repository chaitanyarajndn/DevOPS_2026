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
  depends_on = [module.resource_group, module.subnet]
  source     = "../../modules/04-azurerm_network_security_group"
  nsg        = var.nsg_map
}


module "subnet_network_security_group_association" {
  depends_on = [module.subnet, module.network_security_group]
  source     = "../../modules/05-azurerm_subnet_network_security_group_association"
  nsgas      = var.nsgas_map
  subnet_ID  = module.subnet.subnet_ids
  nsg_ID     = module.network_security_group.nsg_ids
}


module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../modules/06-azurerm_public_ip"
  pip        = var.pip_map
}


module "bastion" {
  depends_on = [module.subnet, module.public_ip]
  source     = "../../modules/07-azurerm_bastion_host"
  bas        = var.bas_map
  pip_ID     = module.public_ip.publicip_ID["bastion-pip"]
  subnet_ID  = module.subnet.subnet_ids["bastion-sbn"]
}



module "virtual_network_peering" {
  depends_on = [module.virtual_network]
  source     = "../../modules/08-azurerm_virtual_network_peering"
  vpeer      = var.vpeer_map
  vn_ID      = module.virtual_network.virtual_netowrk_id
}




module "network_interface" {
  depends_on = [ module.subnet, module.public_ip ]
  source = "../../modules/09-azurerm_network_interface"
  nic = var.nic_map
  subnet_ID = module.subnet.subnet_ids
  pip_ID = module.public_ip.publicip_ID
}



module "network_interface_association" {
  depends_on = [ module.network_interface, module.network_security_group ]
  source = "../../modules/10-azurerm_network_interface_security_group_association"
  nicas = var.nicas_map
  nsg_ID = module.network_security_group.nsg_ids
  nic_ID = module.network_interface.nic_ids
}


module "virtual_machine" {
  depends_on = [ module.network_interface, module.virtual_network_peering, module.subnet_network_security_group_association ]
  source = "../../modules/11-azurerm_linux_virtual_machine"
  linxvm = var.linxvm_map
  nic_ID = module.network_interface.nic_ids
}





