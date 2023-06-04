variable "vm_name" {
    description = "The name of the virtual machine"
    type = string
}

variable "environment" {
    description = "The name of the environment."
    type = string
}

variable "location" {
    description = "The location of the network"
    type = string
}

variable "rg_name" {
    description = "The name of the resource group"
    type = string
}

variable "subnet_id" {
    description = "The subnet id"
    type = string
}

variable "admin_ssh_key" {
    description = "The ssh key"
    type = string
}