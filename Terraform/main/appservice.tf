resource "azurerm_service_plan" "main" {
  name                = local.appServicePlan
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "P1v2"
  tags                = local.common_tags

  lifecycle {
    ignore_changes = [
      tags["CreatedDate"],
      tags["CreatedBy"]
    ]
  }
}

resource "azurerm_linux_web_app" "api" {
  name                = local.webappName-api
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.main.location
  service_plan_id     = azurerm_service_plan.main.id

  app_settings = {
    DOCKER_REGISTRY_SERVER_PASSWORD    = data.azurerm_container_registry.main.admin_password
    DOCKER_REGISTRY_SERVER_URL         = data.azurerm_container_registry.main.login_server
    DOCKER_REGISTRY_SERVER_USERNAME    = data.azurerm_container_registry.main.admin_username
    WEBSITES_ENABLE_APP_SERVICE_STORAG = "false"
    ASPNETCORE_ENVIRONMENT             = var.ASPNETCORE_ENVIRONMENT
    Environment                        = var.environment
  }

  site_config {
    always_on = "true"
    app_command_line = "dotnet CRUDDemo.dll"
    application_stack {
      docker_image     = join("", [data.azurerm_container_registry.main.login_server, "/cruddemo"])
      docker_image_tag = "latest"
    }
  }
  connection_string {
    name  = "CRUDDemoContext"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_mssql_server.main.fully_qualified_domain_name};Authentication=Active Directory Default; Database=${azurerm_mssql_database.main.name};"
  }

  identity {
    type = "SystemAssigned"
  }

  logs {
    application_logs {
      file_system_level = "Verbose"
    }
  }
  tags = local.common_tags
  lifecycle {
    ignore_changes = [
      tags["CreatedDate"],
      tags["CreatedBy"],
      site_config[0].application_stack[0].docker_image_tag
    ]
  }
}
