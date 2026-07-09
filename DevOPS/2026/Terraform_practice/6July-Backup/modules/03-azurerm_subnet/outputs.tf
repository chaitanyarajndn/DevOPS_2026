output "subnet_id" {
  value = { 
    for sbn in azurerm_subnet.SBN : 
    sbn.name => sbn.id
  }
}
