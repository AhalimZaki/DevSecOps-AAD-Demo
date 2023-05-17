terraform {
  required_version = ">= 1.1.9"
  backend "azurerm" {
    resource_group_name  = local.tfResourceGroup
    storage_account_name = local.tfStorage
    container_name       = local.tfContainer
  }
  required_providers {
    azurerm = "3.40.0"
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = local.resourceGroup
  location = local.resourceGroupLocation
  tags     = local.common_tags

  lifecycle {
    ignore_changes = [
      tags["CreatedDate"],
      tags["CreatedBy"]
    ]
  }
}
