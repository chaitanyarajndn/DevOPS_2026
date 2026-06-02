x = {

  RGA = "eastus"
  RGB = "westus"
  RGC = "central india"

}


y = {

sa1 = {
    name                     = "testdevxyza"
    resource_group_name      = "RGA"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }

sa2 = {
    name                     = "testlabxyza"
    resource_group_name      = "RGB"
    location                 = "westus"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }

sa3 = {
    name                     = "testprodxyza"
    resource_group_name      = "RGC"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }


}
