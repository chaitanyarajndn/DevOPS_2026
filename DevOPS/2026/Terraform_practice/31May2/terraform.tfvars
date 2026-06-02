x = {

  rohanrg = "eastus"
  mohanrg = "westus"

}




# x = {

# RGA = {
#     name = "rohanrg"
#     location = "eastus"
# }

# RGB = {
#     name = "mohanrg"
#     location = "westus"
# }

# }


y = {

RGA = {
  name                     = "rohanstrac"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  resource_group_name      = "rohanrg"
  location                 = "eastus"

}

RGB = {
  name                     = "mohanstrac"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  resource_group_name      = "mohanrg"
  location                 = "westus"

}

}


# z = {

# vna = {

#   name                = "tpnet"
#   location            = "RGA"
#   resource_group_name = "RGA"
#   address_space       = ["10.1.0.0/18"]
#   dns_servers         = ["10.0.0.4", "10.0.0.5"]
  
#   sbname1          = "tpsbnet1"
#   address_prefixes1 = ["10.1.1.0/24"]

#   sbname2          = "tpsbnet2"
#   address_prefixes2 = ["10.1.2.0/24"]
# }

# vnb = {

#   name                = "dnet"
#   location            = "RGB"
#   resource_group_name = "RGB"
#   address_space       = ["10.2.0.0/18"]
#   dns_servers         = ["10.0.1.4", "10.0.1.5"]
  
#   sbname1             = "dsbnet1"
#   address_prefixes1 = ["10.2.1.0/24"]


#   sbname2             = "dsbnet2"
#   address_prefixes2 = ["10.2.2.0/24"]
# }


# }
