terraform {
  required_version = ">= 1.1.9"
  required_providers {
    azurerm = "3.4.0"
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  name      = local.resourceGroup
  location  = local.resourceGroupLocation

  tags = local.common_tags
  
  lifecycle {
    ignore_changes = [
      tags["CreatedDate"],
      tags["CreatedBy"]
    ]
  }
}
