resource "azurerm_lb_backend_address_pool" "BackendPool" {
  for_each        = var.bpool
  loadbalancer_id = var.lb_ID
  name            = each.value.name
}







