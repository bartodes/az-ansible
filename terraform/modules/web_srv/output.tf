output "private_ip_address" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.webservers.public_ip_address
} 