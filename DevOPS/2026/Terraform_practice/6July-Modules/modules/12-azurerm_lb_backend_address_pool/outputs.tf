output "lb_backend_pool_id" {
  value = {
    for key, bkp in azurerm_lb_backend_address_pool.BackendPool :
    key => bkp.id
  }
}
