resource "azurerm_container_registry" "main" {
  name                = local.containerRegistry
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Basic"

  admin_enabled = true

  tags = local.common_tags
  
  lifecycle {
    ignore_changes = [
      tags["CreatedDate"],
      tags["CreatedBy"]
    ]
  }
}
