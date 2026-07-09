output "subnet_id" {
  value = { 
    for key, sbn in azurerm_subnet.SBN : 
    key => sbn.id
  }
}
