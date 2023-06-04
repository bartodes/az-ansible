resource "azurerm_resource_group" "rg" {
    name = var.rg_name_root
    location = "East US"
}

resource "tls_private_key" "webservers_ssh" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "linuxkey" {
    filename  = "websrv.pem"
    content   = tls_private_key.webservers_ssh.private_key_pem

    provisioner "local-exec" {
        command = "chmod 400 webservers.pem"
    }
}

module "network_root" {
    source = "./modules/virtual_network"

    rg_name     = azurerm_resource_group.rg.name
    location    = azurerm_resource_group.rg.location
    vnet_name   = "${azurerm_resource_group.rg.name}virtualnetwork"

    environment = var.environment_root
}

module "webserver1_root" {
    source = "./modules/web_srv"

    vm_name                 = "webserver1"
    rg_name                 = azurerm_resource_group.rg.name
    location                = azurerm_resource_group.rg.location

    subnet_id               = module.network_root.webservers_subnet_id
    admin_ssh_key           = tls_private_key.webservers_ssh.public_key_openssh

    environment             = var.environment_root
}

module "webserver2_root" {
    source = "./modules/webs_srv"

    vm_name                 = "webserver2"
    rg_name                 = azurerm_resource_group.rg.name
    location                = azurerm_resource_group.rg.location

    subnet_id               = module.network_root.webservers_subnet_id
    admin_ssh_key           = tls_private_key.webservers_ssh.public_key_openssh   

    environment             = var.environment_root
}

module "database_root" {
    source = "./modules/db"

    rg_name                 = azurerm_resource_group.rg.name
    flexible_server_name    = "${azurerm_resource_group.rg.name}flexibleserver"
    location                = azurerm_resource_group.rg.location

    vnet_id                 = module.network_root.vnet_id
    subnet_id               = module.network_root.database_subnet_id
}

module "loadbalancer_root" {
    source = "./modules/lb"
    
    rg_name                 = azurerm_resource_group.rg.name
    location                = azurerm_resource_group.rg.location

    public_ip_address       = module.network_root.public_ip_address_id
    virtual_network_id      = module.network_root.vnet_id
    webservers_ip_addresses = [
        module.webserver1_root.private_ip_address,
        module.webserver2_root.private_ip_address
    ]
}