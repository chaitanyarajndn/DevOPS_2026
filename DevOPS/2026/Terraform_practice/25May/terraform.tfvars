# rgn = {

#   chetanrg = "eastus"
#   rahulrg  = "westus"
#   keshavrg = "central india"
#   rakeshrg = "south india"
# }

# rgn = ["rahulrg" , "chetanrg" ,"rakeshrg" ]

rgn = {

    RG1 = {
        name = "rahulrg"
        location = "eastus"
        managed_by = "rahul"
        
        sa1 = {
        name                     = "testdevabc"
        location                 = "eastus"
        account_tier             = "Standard"
        account_replication_type = "LRS"
        }
    }

    RG2 = {
        name = "Rakeshrg"
        location = "westus"
        managed_by = "rakesh"
    }

    RG3 = {
        name = "sumitrg"
        location = "westus"
        managed_by = "sumit"
    }

}

strac = {

  stg1 =  {
       
}

stg2 = {
        name                     = "testlababc"
        resource_group_name      = "RG2"
        location                 = "westus"
        account_tier             = "Standard"
        account_replication_type = "LRS"
}

stg3 = {
        name                     = "testprodabc"
        resource_group_name      = "RG3"
        location                 = "centralindia"
        account_tier             = "Standard"
        account_replication_type = "LRS"
}


}
