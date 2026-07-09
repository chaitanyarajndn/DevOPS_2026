variable "rg" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "lc" {
  description = "Azure Region"
  type        = string
}

variable "vn" {
  description = "Azure Virtual Network for Linux VM"
  type        = string
}

variable "ipadd" {
  description = "Address Space for Linux VM"
  type = list(string)
}

