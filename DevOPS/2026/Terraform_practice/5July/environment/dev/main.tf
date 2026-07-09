module "resource_group" {
    source = "../../modules/azurerm_resource_group"

    rg = var.rg
    lc = var.lc
}

module "virtual_network" {
  source = "../../modules/azurerm_virtual_network"

  vn    = var.vn
  lc    = var.lc
  rg    = module.resource_group.resource_group_name
  ipadd = var.ipadd

}












