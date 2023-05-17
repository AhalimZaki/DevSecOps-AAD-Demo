resource "azurerm_mssql_server" "main" {
  name                         = local.sqlserverName
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  minimum_tls_version          = "1.2"

  public_network_access_enabled = true

  azuread_administrator {
    azuread_authentication_only = true
    login_username                  = "spn-resouces"
    object_id                       = data.azurerm_client_config.current.object_id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags
    lifecycle {
    ignore_changes = [
      tags["CreatedDate"],
      tags["CreatedBy"]
    ]
  }
}

resource "azurerm_mssql_database" "main" {
  name           = local.sqlDBName
  server_id      = azurerm_mssql_server.main.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  sku_name       = "Basic"

  tags = local.common_tags
    lifecycle {
    ignore_changes = [
      tags["CreatedDate"],
      tags["CreatedBy"]
    ]
  }

}

resource "azurerm_mssql_firewall_rule" "main" {
   name = local.fireWallName
   server_id      = azurerm_mssql_server.main.id
   start_ip_address = "0.0.0.0"
   end_ip_address = "0.0.0.0"
}