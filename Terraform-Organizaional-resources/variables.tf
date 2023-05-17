variable "environment" { type = string }

locals {

  common_tags = {
    Application       = "OrganizationalResources"
    CreatedDate       = timestamp()
    Environment       = var.environment
    Owner             = "DevSecOps"
    CreatedBy         = "DevSecOps"
    PipelineManaged   = true
    PipelineDeployed  = timestamp()
  }
resourceGroup = join("", ["rg-mainResources-", var.environment]) 
resourceGroupLocation = "West Europe"
containerRegistry = join("", ["acrOrganizationahalimdemodevsecops", var.environment]) ## It must have a Unique naming
storageAccount = join("", ["tfstatedevsecopsdemo", var.environment]) ## It must have a Unique naming
}

