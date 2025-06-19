# Terraform Data Types:

Terraform data types fall into two main categories:

# 1. Primitive Types:

1.string

2.number

3.bool

# 2. Complex Types:

4.list(type)

5.set(type)

6.map(type)

7.object({key = type, ...})

8.tuple([type, type, ...])

# 1.string

A single line of text.

variable "env" {
  type    = string
  default = "production"
}

# 2.number

A numeric value (integer or float).

Terraform number is a primitive type that represents both:

Integer values (e.g., 1, 5, 100)

Floating-point values (e.g., 1.5, 0.01, 3.14)

variable "vm_count" {
  type    = number
  default = 3
}

#  Integer Example

variable "vm_count" {
  type    = number
  default = 3
}

output "number_of_vms" {
  value = var.vm_count
}

# Note : This is useful for things like count, replica_count, etc.


# Float Example:

variable "cost_per_hour" {
  type    = number
  default = 0.025
}

output "hourly_cost" {
  value = var.cost_per_hour
}

# Note : Used for pricing, calculations, or thresholds.

# Example: Using Both Together

variable "vm_count" {
  type    = number
  default = 4
}

variable "cost_per_hour" {
  type    = number
  default = 0.125
}

output "total_hourly_cost" {
  value = var.vm_count * var.cost_per_hour
}

# 3. bool:

A true/false value.

variable "is_enabled" {
  type    = bool
  default = true
}

# 4. list(type):

An ordered collection of values, all of the same type.

variable "az_regions" {
  type    = list(string)
  default = ["eastus", "westus", "centralus"]
}

# 5. set(type) :

An unordered collection of unique values of the same type.

variable "vm_tags" {
  type    = set(string)
  default = ["dev", "test", "prod"]
}

# Difference from list:

list allows duplicates, maintains order.

set doesn't allow duplicates, no guaranteed order.

# 6. map(type)

A group of key-value pairs with the same type for all values.

variable "instance_sizes" {
  type = map(string)
  default = {
    dev  = "Standard_B1s"
    prod = "Standard_B2s"
  }
}

# 7. object({ ... }) 

A collection of named attributes with potentially different types.

variable "app_config" {
  type = object({
    name    = string
    enabled = bool
    port    = number
  })

  default = {
    name    = "myapp"
    enabled = true
    port    = 8080
  }
}

# 8. tuple([type1, type2, ...]):

An ordered list of elements of different types.

An ordered list of elements of different types.

variable "my_tuple" {
  type = tuple([string, number, bool])
  default = ["web", 3, true]
}

 # Example Use in Resource:

 variable "vm_config" {
  type = object({
    name     = string
    size     = string
    location = string
  })

  default = {
    name     = "vm01"
    size     = "Standard_B1s"
    location = "eastus"
  }
}

resource "azurerm_virtual_machine" "example" {
  name     = var.vm_config.name
  location = var.vm_config.location
  ...
}

# Default Variable Type (Implicit Type):

If you don’t specify type, Terraform infers it from the default.

variable "region" {
  default = "eastus" # inferred as string
}

# When to Use Each Type?

| Use Case                    | Type                            |
| --------------------------- | ------------------------------- |
| Simple string, number, flag | `string`, `number`, `bool`      |
| Multiple strings            | `list(string)` or `set(string)` |
| Key-value pairs             | `map(type)`                     |
| Structured config           | `object({})`                    |
| Mixed types in order        | `tuple([])`                     |

# Terraform Data Types and Where to Use in Azure

| Use Case                    | Terraform Type                | **Where to Use in Azure**                                                                                   |
| --------------------------- | ----------------------------- | ----------------------------------------------------------------------------------------------------------- |
| Simple string, number, flag | `string`, `number`, `bool`    | - VM name<br>- Resource group name<br>- Number of VMs<br>- Enable/disable diagnostics/logs (`bool`)         |
| Multiple strings            | `list(string)`, `set(string)` | - List of Azure regions<br>- VM tags<br>- IP whitelists<br>- NSG allowed IPs                                |
| Key-value pairs             | `map(type)`                   | - Tags for resources<br>- Environment-specific variables (e.g., `dev`, `prod` configs)<br>- Storage tiers   |
| Structured config           | `object({})`                  | - Full VM config<br>- AKS cluster settings<br>- App Service plan config                                     |
| Mixed types in order        | `tuple([])`                   | - Return values from `lookup()`<br>- Passing variable sequences to modules with fixed positional parameters |


# Examples Per Type with Azure Resources:

# string, number, bool

Used for simple parameters like names, counts, and flags.

variable "location" {
  type    = string
  default = "eastus"
}

variable "vm_count" {
  type    = number
  default = 2
}

variable "enable_diagnostics" {
  type    = bool
  default = true
}

# Note : Used in:

azurerm_virtual_machine

azurerm_storage_account

azurerm_network_interface

# list(string) or set(string)

Used for multiple values of the same type.

variable "allowed_ips" {
  type    = list(string)
  default = ["1.2.3.4/32", "5.6.7.8/32"]
}

# Used in:

NSG security rules (azurerm_network_security_rule)

IP restrictions for Azure Web Apps

Backup region selection

# map(string)

Used for key-value pairs like tags or environment-based values.

variable "resource_tags" {
  type = map(string)
  default = {
    environment = "dev"
    owner       = "sarath"
  }
}

# Used in:

Tagging across all Azure resources

Dynamically selecting VM sizes or configs based on environment

# object({})

Used when defining a structured configuration.

variable "vm_config" {
  type = object({
    name     = string
    size     = string
    location = string
  })

  default = {
    name     = "vm1"
    size     = "Standard_B2s"
    location = "eastus"
  }
}

# Used in:

azurerm_virtual_machine

azurerm_kubernetes_cluster

Complex input to modules

# tuple([])

Used when you have mixed types in a specific order.

variable "dns_record" {
  type    = tuple([string, number, bool])
  default = ["webserver", 3600, true]
}

# Used in:

Azure DNS record sets

Multi-return values from modules/functions

Values where order matters (e.g., tuple for lat-long coordinates, or timeouts)

# Summary Table (Azure-Specific Context)
| Type           | Used for in Azure                                      |
| -------------- | ------------------------------------------------------ |
| `string`       | Names, locations, SKUs                                 |
| `number`       | VM count, capacity settings, timeouts                  |
| `bool`         | Flags like enable monitoring, enable diagnostics       |
| `list(string)` | NSG IPs, availability zones, subnet lists              |
| `set(string)`  | Tags, whitelisted IPs                                  |
| `map(string)`  | Tags, environment-based configs                        |
| `object({})`   | VM/AKS/App config, structured module inputs            |
| `tuple([])`    | DNS records, mixed-type configs, positional parameters |




