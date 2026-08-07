output "subnet_ids" {
  value = {
    for key, sbn in azurerm_subnet.SBN :
    key => sbn.id
  }
}

