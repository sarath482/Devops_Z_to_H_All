# Variables adding in execution

# This command runs a Terraform plan using a custom value for the environment variable without needing a .tfvars file.

terraform plan -var=environment=dev

tf plan -var=environment=prod

Terraform Variable Types
There are two main categories:

# 1. Primitive Types

string

number

bool

# 2. Complex Types

list

map

set

object

tuple

# Summary Table

| Type     | Example                              | Use Case                   |
| -------- | ------------------------------------ | -------------------------- |
| `string` | `"dev"`                              | Environment, names         |
| `number` | `3`, `1.5`                           | Count, size                |
| `bool`   | `true`, `false`                      | Feature flags              |
| `list`   | `["web1", "web2"]`                   | Repeating values           |
| `set`    | `["eastus", "westus"]`               | Unique, unordered values   |
| `map`    | `{ env = "dev", owner = "sarath" }`  | Tagging, label configs     |
| `object` | Custom fields like `{name, version}` | App or infra config struct |
| `tuple`  | `["vm1", 2, true]`                   | Mixed-type ordered values  |

 # Input Variables

Used to parameterize your Terraform configuration. These are values passed into the module/code.

Example:

# variables.tf
variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "dev"
}

# main.tf
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environment}"
  location = "East US"
}


# Use case:

You want to deploy to different environments (dev, prod, stage) by changing only variable values, not the core code.

terraform apply -var="environment=prod"

# 2. Output Variables:

Used to print useful info from Terraform after deployment (e.g., resource name, IPs).

Example:

# outputs.tf
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_id" {
  value = azurerm_storage_account.sa.id
}

# Use case:

You want to see or pass Terraform outputs to external systems (e.g., CI/CD pipelines, other scripts).

terraform output resource_group_name

# 3. Locals

Used to define temporary values (derived or computed) to simplify complex expressions.

Example:

# main.tf
locals {
  base_name = "myproject"
  location  = "East US"
  full_name = "${local.base_name}-${var.environment}"
}

resource "azurerm_resource_group" "rg" {
  name     = local.full_name
  location = local.location
}

# Use case:

You want to avoid repeating code or build dynamic names based on logic.

# Summary Table

| Concept             | Purpose                          | Real-World Use Case                               |
| ------------------- | -------------------------------- | ------------------------------------------------- |
| **Input Variable**  | Accepts values from user/config  | Changing environment, region, sizes dynamically   |
| **Output Variable** | Displays values after apply      | Show resource names, IPs, URLs                    |
| **Local**           | Defines reusable internal values | Build naming standards, simplify long expressions |


# Issue 

tags= {
      environment = local.common_tags.stage # here if user not provided stage tage like below 
    }

    tags= {
      environment = local.common_tags
    }

# Issue :
tf plan
╷
│ Error: Incorrect attribute value type
│ 
│   on main.tf line 39, in resource "azurerm_storage_account" "sa":
│   39:     tags= {
│   40:       environment = local.common_tags
│   41:     }
│     ├────────────────
│     │ local.common_tags is object with 3 attributes
│ 
│ Inappropriate value for attribute "tags": element "environment": string required.