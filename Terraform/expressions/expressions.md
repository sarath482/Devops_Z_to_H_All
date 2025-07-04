#  1. Dynamic Expressions

What is it?
Used to dynamically build nested blocks like tags, settings, or ingress_rules.

You use dynamic when you don’t know the exact number or content of nested blocks at coding time.
 Where?
Inside a resource or module block when looping through sub-blocks like tag, rule, settings, etc.

Syntax:

dynamic "tag" {
  for_each = var.tags
  content {
    key   = tag.key
    value = tag.value
  }
}

# Example: Dynamic tags for Resource Group

resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "East US"

  dynamic "tags" {
    for_each = var.environment == "prod" ? {
      Owner = "admin"
      CostCenter = "123"
    } : {}

    content {
      key   = tags.key
      value = tags.value
    }
  }
}

# 2. Conditional Expressions (? :)

 What is it?
Select values based on conditions.

 Where?

Anywhere: variable values, resource properties, outputs, locals.

Syntax:

condition ? value_if_true : value_if_false

# Example: Region-specific Resource Group Name

resource "azurerm_resource_group" "example" {
  name     = var.env == "prod" ? "rg-prod" : "rg-dev"
  location = "East US"
}

Another example :

output "tier" {
  value = var.env == "prod" ? "Premium" : "Basic"
}

# 3. Splat Expressions ([*])

What is it?

Used to extract multiple values from a list of resources or objects.

Returns lists of values from repeated resources or attributes.

Where?

When you use count or for_each, and want a list of all values from each instance.

Syntax:

resource_type.resource_name[*].attribute

# Example: Get all NIC IDs

resource "azurerm_network_interface" "example" {
  count               = 3
  name                = "nic-${count.index}"
  location            = "East US"
  resource_group_name = azurerm_resource_group.example.name
  ...
}

output "nic_ids" {
  value = azurerm_network_interface.example[*].id
}

# Summary Table
 | Expression Type     | Purpose                         | Example                |
| ------------------- | ------------------------------- | ---------------------- |
| `dynamic`           | Build nested blocks dynamically | Tags, NSG rules        |
| `condition ? x : y` | Conditionally assign values     | Region-based naming    |
| `splat [*]`         | Extract lists from resources    | Get list of IDs or IPs |

# Combined Usage Example

resource "azurerm_network_security_group" "nsg" {
  name                = "web-nsg"
  location            = "East US"
  resource_group_name = azurerm_resource_group.example.name

  dynamic "security_rule" {
    for_each = var.env == "prod" ? local.prod_rules : []

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}
