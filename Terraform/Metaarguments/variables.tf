variable "environment" {
    type = string
    description = "The Environment Type"
    default = "staging"  
}
variable "storage_disk"{
    type = number
    description = "the storage disk size of OS"
    default = 80
  
}

variable "is_delete" {
    type = bool
    description = "the default behaviour of disk upon vm termination"
    default = true
  
}
variable "allowed_locations" {
   type = list (string)
   description = "list of allowed location"
   default = [ "West Europe","North Europe","East Us" ]
 
}
variable "resource_tags" {
    type = map(string)
    description = "tages to apply the resources"
    default = {
      "environment" = "staging"
      "managed_by" = "terraform"
      "department" = "devops"
    }
}

# Tuple Type
variable "network_config" {
    type = tuple([ string,string,string ])
    description = "Network configuration (VNET address , subnet,address,subnet mask)"
    default = [ "10.10.0.0./16", "10.0.2.0", 24 ]
  
}

variable "allowed_vm_sizes" {
    type = list(string)
    description = "Allowed Vm size"
    default = [ "Standard_DS1_v2","Standard_Ds2_v2","Standard_DS3_v2" ]
  
}

# object type

variable "vm_config" {
    type = object({
      size = string
      publisher = string
      offer=string
      sku=string
      version=string 
    })
    description = "Virtual machine configuration"
    default = {
      size = "Standard_DS1_v2"
      publisher = "Canonical"
      offer = "0001-com-ubuntu-server-jammy"
      sku = "22_04_lts"
      version = "latest"
    }
  
}

variable "storage_account_name" {
    type = set(string)
    default = ["sarathac12","sarathsa13"]
}



