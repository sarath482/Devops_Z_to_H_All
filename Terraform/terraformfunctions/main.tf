locals {
  formatted_name = lower(replace(var.project_name," ","-"))
  merge_tags = merge(var.default_tags,var.environment_tags)
  storage_formated = replace(replace(lower(substr(var.storage_account_name,0,23))," ",""),"!","")
  #var.storage_account_name :Refers to a variable (user input) for the desired storage account name
  #substr(..., 0, 23) :Extracts the first 23 characters (Azure storage account name max is 24)
  #lower(...)	Converts the result to lowercase (Azure requires lowercase names)
  #replace(..., " ", "")	Removes spaces from the name
  #replace(..., "!", "")	Removes exclamation marks from the name (you can chain more replace if needed for other characters)
  #Output :storage_account_name = "sarathazazuredevopss" [Input :sarathAZ azuredevops! should be formated]
formated_ports = split(",",(var.allowed_ports))
nsg_rules = [for port in local.formated_ports :
{
  name = "port-${port}"
  port =port
  description ="Allowed traffic on port: ${port}"
  #Changes to Outputs: It is showing the same in the remaining two values as well."
  #+ nsg_rules            = [
    #  + {
    #      + description = "Allowed traffic on port: 80"
    #      + name        = "port-80"
    #      + port        = "80"
}

]

vm_sizes = lookup(var.vm_sizes,var.environment,lower("dev"))
#assignment 9

user_location = ["eastus", "westus","eastus"]
default_location = ["centralus"]

unique_location = toset(concat(local.user_location,local.default_location))

#assignment 10
monthly_costs = [-50, 100, 75, 200]
positive_cost = [for cost in local.monthly_costs :
abs(cost)]
max_cost = max(local.positive_cost...)

# Assignment 11

current_time = timestamp()
resource_name = formatdate("YYYYMMDD",local.current_time)
tag_date = formatdate("DD-MM-YYYY",local.current_time)

# Assignment 12 
config_content = sensitive(file(config.json))


}


resource azurerm_resource_group rg {
 name = "${local.formatted_name}-rg"
 location = "Westus2"

  
}
resource "azurerm_storage_account" "example" {
  name = local.storage_formated
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_tier = "Standard"
  account_replication_type = "GRS"

  tags = local.merge_tags
    
}
# Create Network Security Group
resource "azurerm_network_security_group" "example" {
  name                = "${local.formatted_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Here's where we need the dynamic block
  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = security_rule.key
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range         = "*"
      destination_port_range    = security_rule.value.port
      source_address_prefix     = "*"
      destination_address_prefix = "*"
      description               = security_rule.value.description
    }
  }
}

output "rgname"{
    value = azurerm_resource_group.rg.name
  
}

output "storage_account_name" {
  value = azurerm_storage_account.example.name
  
}
output "nsg_rules" {
  value = local.nsg_rules
  
}
output "vm_sizes" {
  value = local.vm_sizes
  
}
output "backup" {
  value = var.backup_name
  
}

output "credentials" {
  value = var.credentials
  sensitive = true
  
}

output "unique_location" {
  value = local.unique_location
  
}

output "max_cost" {
  value = local.max_cost
  
}

output "positive" {
  value = local.positive_cost
  
}

output "resource_name" {
  value = local.tag_date
  
}