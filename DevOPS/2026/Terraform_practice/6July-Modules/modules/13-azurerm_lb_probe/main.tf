resource "azurerm_lb_probe" "HealthProbe" {
  for_each            = var.lbprobe
  loadbalancer_id     = var.lb_ID
  name                = each.value.name
  protocol            = each.value.protocol
  port                = each.value.port
  request_path        = each.value.request_path
  interval_in_seconds = each.value.interval_in_seconds
}
