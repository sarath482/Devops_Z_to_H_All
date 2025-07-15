resource "azurerm_resource_group" "rg"{
  name = "${var.environment}-resources"
  location = var.allowed_locations[2]
}
resource "azurerm_storage_account" "sa" {
  #count = length(var.storage_account_name)
  for_each = var.storage_account_name
  #for_each = var.storage_account_name
  name = each.value
  #name = var.storage_account_name[count.index]
  #count = 2
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_tier = "Standard"
  account_replication_type = "GRS"

  tags = {  
    environment = "staging"
    }
  
}

