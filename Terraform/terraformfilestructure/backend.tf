terraform {
  backend "azurerm" {
    resource_group_name = "tfstate-day04"
    storage_account_name = "day048825"
    container_name = "tfstate"
    key = "dev.terraform.tfstate"
  }
}