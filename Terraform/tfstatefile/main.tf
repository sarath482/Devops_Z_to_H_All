terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.8.0" # Allow versions >= 4.8.0 but < 4.9.0(The ~> operator is called the pessimistic constraint operator.)
    }
    
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-day04"  # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "day044652"                      # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "dev.terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
  required_version = ">= 1.9.0" # Only allow Terraform version 1.9.0 or higher to run this code.
}

provider "azurerm" {
    features {}
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
      environment = "staging"
    }
  
}
