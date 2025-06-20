terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.8.0" # Allow versions >= 4.8.0 but < 4.9.0(The ~> operator is called the pessimistic constraint operator.)
    }
  }
  required_version = ">= 1.9.0" # Only allow Terraform version 1.9.0 or higher to run this code.
}
provider "azurerm"{
    features {}
} 
variable "environment" {
    type = string
    description = "the env type"
    default = "staging"
  
}
locals {
  common_tags = {
    environment = "dev"
    lob = "banking"
    stage = "alpha"
  }
}

resource "azurerm_resource_group" "rg" {
    name = "sarathAz_rg"
    location = "West Europe"
  
}
resource "azurerm_storage_account" "sa" {
    name = "sarathblobs1"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location # implicit dependency
    account_tier = "Standard"
    account_replication_type = "LRS"
    
    tags= {
      environment = local.common_tags.lob
    }
  
}

output "azurerm_storage_account" {
    value = azurerm_resource_group.rg.name
     
}

output "storage_account_location" {
    value = azurerm_storage_account.sa.location
  
}