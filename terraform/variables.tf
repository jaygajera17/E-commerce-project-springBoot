variable "resource_group_name" {
  type    = string
  default = "ecommerce-rg"
}

variable "location" {
  type    = string
  default = "Central India"
}

variable "acr_name" {
  type    = string
  default = "maheshpasapalaacr"
}

variable "aks_name" {
  type    = string
  default = "ecommerce-aks"
}

variable "node_count" {
  type    = number
  default = 1
}

variable "node_vm_size" {
  type    = string
  default = "Standard_B2s"
}