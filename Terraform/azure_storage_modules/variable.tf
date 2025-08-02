variable "resource_group_name"  {
 description = "Name of the resource group"
 type = string 
}

variable "location" {
    description = "Azure region"
    type   = string
}

variable "tags" {
  description = "common tags"
  type = map(string)
}