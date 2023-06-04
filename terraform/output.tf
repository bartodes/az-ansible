output "webserver1_public_ip_address" {
  value = module.webserver1_root.public_ip_address
}

output "webserver2_public_ip_address" {
  value = module.webserver2_root.public_ip_address
} 