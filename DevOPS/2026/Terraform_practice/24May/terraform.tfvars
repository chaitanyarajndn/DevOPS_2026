rg_name = {

    RG1 = {
        name = "RGabcx"
        location = "eastus"
    }

    RG2 = {
        name = "RGabcy"
        location = "westus"
    }

    RG3 = {
        name = "RGabcz"
        location = "centralindia"
    }
}

strac = {
RG1 ={
  name                     = "testdevabc"
  resource_group_name      = "RGabcx"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

RG2 ={
   name                     = "testlababc"
  resource_group_name      = "RGabcy"
  location                 = "westus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

RG3 ={
  name                     = "testprodabc"
  resource_group_name      = "RGabcz"
  location                 = "centralindia"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

}