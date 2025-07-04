output "rgname" {
    value = azurerm_resource_group.rg[*].name
  #output 
  #Changes to Outputs:
  #+ rgname = "staging-resources" 
}
output "storage_name" {
    value = [for i in azurerm_storage_account.sa: i.name]
    #output 
    #+ storage_name = [
    #  + "sarathac12",
    #  + "sarathsa13",
   # ]
  
}
