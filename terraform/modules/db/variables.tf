variable "rg_name" {
  description = "The name of the resource group."
  type = string
}

variable "flexible_server_name" {
  description = "The flexible server name."
  type = string
}   

variable "vnet_id" {
  description = "The virtual network id."
  type = string
}

variable "subnet_id" {
  description = "The subnet id."
  type = string
}

variable "location" {
  description = "The location of the resource group."
  type = string
}   