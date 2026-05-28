rg = {

  RGA = {

    name      = "rahulrg"
    location  = "eastus"
    managedby = "rahul"
    }

  RGB = {

      name      = "rohanrg"
      location  = "westus"
      managedby = "rohan"
      }

    }


str = {

sa1 = {
      name      = "testdevabc"
      location  = "eastus"
      resource_group_name = "RGA"
      account_tier = "Standard"
      account_replication_type  = "LRS"
    }


  sa2 = {
        name      = "testprodabc"
        location  = "westus"
        resource_group_name = "RGB"
        account_tier = "Standard"
        account_replication_type  = "LRS"
  }

}