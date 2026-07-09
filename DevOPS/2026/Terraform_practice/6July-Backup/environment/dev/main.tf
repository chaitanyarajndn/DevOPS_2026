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
  for_each = var.nic_map
  source = "../../modules/09-azurerm_network_interface"
  name                          = each.value.name
  location                      = each.value.location
  resource_group_name           = each.value.resource_group_name
  subnet_id                     = module.subnet.subnet_id[each.value.subnet_id]
  ipname                        = each.value.ipname
  private_ip_address_allocation = each.value.private_ip_address_allocation

}













