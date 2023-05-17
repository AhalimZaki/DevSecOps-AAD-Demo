output "APIAppName" {
  value = resource.azurerm_linux_web_app.api.name
}

output "dbServer" {
  value = resource.azurerm_mssql_server.main.fully_qualified_domain_name
}

output "dbName" {
  value = resource.azurerm_mssql_database.main.name
}
output "servicePrincipalId" {
  value = data.azurerm_client_config.current.object_id
}