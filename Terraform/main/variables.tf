# CLI Arguments
variable "pipelineURI" {type = string}
variable "environment" {type = string}
variable "projectName" { type = string }
variable "privilegedUsers" { type = string }
# Environment Arguments
variable "ASPNETCORE_ENVIRONMENT" { type = string }

locals {    
    common_tags = {
      Application = "AzureDemo"
      CreatedDate = timestamp()
      Environment = var.environment
      PipelineURL = var.pipelineURI
      Owner       =  "DevSecOps"
      CreatedBy   =  "DevSecOps"
  }
#backend init
tfResourceGroup= "rg-mainResources-prod"
tfStorage = "tfstatedevsecopsdemoprod"
tfContainer = "tfstate-cruddemo"
acrRegistry = "acrOrganizationahalimdemodevsecopsprod"
sqlServerGroup = "Azure SQL Server Groups Administrator"
#tf normal vars
resourceGroup = join("", ["rg-", var.projectName, "-", var.environment])
resourceGroupLocation = "West Europe"
fireWallName = join("", ["arc", var.projectName, "-", var.environment])  
keyVaultName = join("", ["akv-", var.projectName, "-", var.environment]) 
webappName-api = join("",["wa-", var.projectName, "-api-", var.environment])
appServicePlan = join("", ["asp-", var.projectName, "-", var.environment])
sqlserverName = lower( join("", ["sql-", var.projectName, "-", var.environment]))
sqlDBName = lower( join("", ["sqldb-", var.projectName, "-", var.environment]))
}