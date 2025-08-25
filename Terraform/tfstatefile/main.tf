terraform {                          # This block configures Terraform itself (which provider to use, which version, and where to store the state file).
  required_providers {               # Purpose: Tells Terraform which cloud provider plugin (provider) to use
    azurerm = {                      # Here, we’re using AzureRM provider (azurerm) from HashiCorp
        source = "hashicorp/azurerm" # version = "~> 4.8.0" → Means: Minimum: 4.8.0  Maximum: Anything below 4.9.0
        version = "~> 4.8.0"          # Allow versions >= 4.8.0 but < 4.9.0(The ~> operator is called the pessimistic constraint operator.)
    }                                 # Note : Why? This ensures you don’t accidentally break your code when new incompatible versions are released.
    
  }                      
  backend "azurerm" {                 # Purpose: Defines where Terraform state file (terraform.tfstate) will be stored.
    resource_group_name  = "tfstate-day04"  # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "day044652"                      # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "dev.terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
  required_version = ">= 1.9.0" # Only allow Terraform version 1.9.0 or higher to run this code.
}                               # Ensures Terraform version used is at least 1.9.0.(If someone tries to run your code with an older version (say 1.6.0), Terraform will throw an error.)

provider "azurerm" {          # This initializes the AzureRM provider (the plugin that lets Terraform talk to Azure).
    features {}               #  features {} is mandatory, even if empty. It enables certain provider features (like virtual machine scale sets, AKS, etc.).
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
