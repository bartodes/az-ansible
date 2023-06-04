variable "rg_name" {
  description = "The name of the resource group."
  type = string
}

variable "location" {
  description = "The resource group location."
  type = string
} 

variable "vnet_name" {
  description = "The name of the virtual network."
  type = string
}

variable "environment" {
  description = "The name of the environment."
  type = string
}