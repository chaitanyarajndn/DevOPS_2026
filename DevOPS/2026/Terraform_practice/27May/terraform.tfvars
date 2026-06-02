rg = {

    gauravrg = "eastus"
    sonurg = "westus"
}


vn = {

 
 vna = {
  name                = "tryvnabc"
  resource_group_name = "gauravrg"
  location            = "easutus"
  address_space       = ["10.1.0.0/16"]
   sbname             = "snet1"
   sbaddress_prefixes = ["10.1.1.0/28"]
}


vnb = {
  name                = "tryvnxyz"
  resource_group_name = "sonurg"
  location            = "westus"
  address_space       = ["10.2.0.0/16"]
  sbname             = "snet2"
  sbaddress_prefixes = ["10.2.1.0/28"]

}


}