resource "azurerm_storage_account" "sa" {
  name = "sarathblob1"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_tier = "Standard"
  account_replication_type = "GRS"

  tags = { 
    environment = local.common_tags.environment
   }
  
}