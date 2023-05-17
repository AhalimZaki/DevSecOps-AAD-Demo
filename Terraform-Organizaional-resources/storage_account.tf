
resource "azurerm_storage_account" "main" {
  name                     = local.storageAccount
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = local.common_tags

  lifecycle {
    ignore_changes = [
      tags["CreatedDate"],
      tags["CreatedBy"]
    ]
  }
}

resource "azurerm_storage_container" "configs" {
  name                  = "tfstate-cruddemo"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "blob"
}