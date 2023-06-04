output "vnet_id" {
    value = azurerm_virtual_network.vnet.id
}

output "database_subnet_id" {
    value = azurerm_subnet.database_subnet.id
}

output "public_ip_address_id" {
    value = azurerm_public_ip.loadbalancer_public_ip.id
}

output "webservers_subnet_id" {
    value = azurerm_subnet.webservers_subnet.id
}