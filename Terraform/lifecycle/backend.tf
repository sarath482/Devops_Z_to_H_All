terraform {
  backend "azurerm" {
    resource_group_name = "tfstate-day04"
    storage_account_name = "day0428370"
    container_name = "tfstate"
    key = "dev.terraform.tfstate"
  }
}

