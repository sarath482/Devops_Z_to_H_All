variable "storage_account_name" {
    description = "The name of the storage account"
    type = string
  
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}

variable "location" {
    description = "Azure location where storage account will be created"
    type = string
  
}

variable "account_tier" {
    description = "storage account tier standard or premium"
    type = string
    default = "Standard"
  
}

variable "replication_type" {
    description = "Replication type (LRS,GRS,ZRS,..etc)"
    type = string
    default = "LRS"

}

variable "tags" {
    description = "Tags for the storage account"
    type = map(string)
    default = {}
  
}