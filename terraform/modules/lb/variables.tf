variable "rg_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the network."
  type        = string
}

variable "public_ip_address" {
  description = "The public ip address."
  type        = string
}

variable "virtual_network_id" {
  description = "The virtual network id."
  type        = string
}

variable "webservers_ip_addresses" {
  description = "The webservers ips."
  type        = list(string)
} 