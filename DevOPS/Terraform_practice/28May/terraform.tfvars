rg = {

RGA = {
    name = "abcrg"
    location = "eastus"
}

RGB = {
    name = "xyzrg"
    location = "westus"

}

RGC = {
    name = "mncrg"
    location = "central india"
}

}

vn = {

vna = {

  name                = "vnabc"
  location            = "eastus"
  resource_group_name = "RGA"
  address_space       = ["10.10.0.0/16"]
 

}


vnb = {

     name             = "vnxyz"
  location            = "westus"
  resource_group_name = "RGB"
  address_space       = ["10.20.0.0/16"]
  

}


vnc = {

  name                = "vnmnc"
  location            = "central india"
  resource_group_name = "RGC"
  address_space       = ["10.30.0.0/16"]
 
}

}

sb = {

sba = {

   name             = "sbneta"
    resource_group_name  = "RGA"
  virtual_network_name = "vna"
  address_prefixes    = ["10.10.1.0/24"]

}


sbb = {
    name             = "sbnetb"
     resource_group_name  = "RGB"
  virtual_network_name = "vnb"
  address_prefixes     = ["10.20.1.0/24"]
}


sbc = {

   name             = "sbnetmnc"
  resource_group_name  = "RGC"
   virtual_network_name = "vnc"
    address_prefixes = ["10.30.1.0/24"]
}

}