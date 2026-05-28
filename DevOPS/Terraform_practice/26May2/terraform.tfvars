a = {

  RGabcx = "eastus"
  RGabcy = "westus"
  RGabcz = "central india"

}

b = {

  RG1 = {
    name                     = "testdevxyza"
    resource_group_name      = "RGabcx"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
  RG2 = {
    name                     = "testlabxyza"
    resource_group_name      = "RGabcy"
    location                 = "westus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
  RG3 = {
    name                     = "testprodxyza"
    resource_group_name      = "RGabcz"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }


}