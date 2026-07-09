output "load_balancer_id" {
  value = {
    for key, lb in azurerm_lb.LINXLB :
    key => lb.id
  }
}
