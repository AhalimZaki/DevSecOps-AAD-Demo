
data "azuread_group" "sql" {
  display_name     = local.sqlServerGroup
}
resource "azuread_group_member" "main" {
  group_object_id  = data.azuread_group.sql.id
  member_object_id = azurerm_mssql_server.main.identity[0].principal_id
}

data "azuread_client_config" "current" {}
data "azurerm_client_config" "current" {}

data "azurerm_container_registry" "main" {
  name                = local.acrRegistry
  resource_group_name = local.orgResourceGroup
}
