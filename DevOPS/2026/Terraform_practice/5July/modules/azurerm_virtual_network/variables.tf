variable "vn" {
  description = "Azure Virtual Network Name"
  type        = string
}

variable "rg" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "lc" {
  description = "Azure Region"
  type        = string
}

variable "ipadd" {
  description = "Virtual Network Address Space"
  type        = list(string)
}



