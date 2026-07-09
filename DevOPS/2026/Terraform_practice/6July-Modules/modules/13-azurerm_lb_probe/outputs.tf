output "lb_health_probe_id" {
  value = {
      for key, prb in azurerm_lb_probe.HealthProbe :
      key => prb.id
  }
}