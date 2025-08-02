
resource "azurerm_resource_group" "this" {
  name = var.resource_group_name
  location = var.location
  
}

module "dev_storage" {
    source = "./modules/storage_account"
    storage_account_name = "devstorageacc123"
    resource_group_name = azurerm_resource_group.this.name
    location = var.location
    account_tier = "Standard"
    replication_type = "LRS"
    tags  = var.tags
  
}

module "qa_storage" {
    source = "./modules/storage_account"
    storage_account_name = "qaaccount1234azure"
    resource_group_name = azurerm_resource_group.this.name
    location = var.location
    account_tier = "Standard"
    replication_type = "ZRS"
    tags = var.tags 
}

module "prod_storage" {
    source = "./modules/storage_account"
    storage_account_name = "prodstorageacc1234"
    resource_group_name = azurerm_resource_group.this.name
    location = var.location
    account_tier = "Premium"
    replication_type = "GRS"
    tags = var.tags
}