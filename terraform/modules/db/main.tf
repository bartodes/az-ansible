resource "azurerm_private_dns_zone" "example" {
  name                  = "webservers.mysql.database.azure.com"
  resource_group_name   = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "testVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.rg_name
}

resource "azurerm_mysql_flexible_server" "flexible_server" {
  name                   = var.flexible_server_name
  resource_group_name    = var.rg_name
  location               = var.location
  administrator_login    = "mysqladmin"
  administrator_password = "H@Sh1CoR3!"
  backup_retention_days  = 7
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.example.id
  sku_name               = "B_Standard_B1s"

  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]
}
