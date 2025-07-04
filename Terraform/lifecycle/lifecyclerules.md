# 1. create_before_destroy

 What It Does:
 
Ensures that a new resource is created first, and then the old one is destroyed, to avoid downtime.

Use Case:

This is most useful for resources that support replacement (e.g., VMs, NSGs, or App Services), but not supported for all types like Resource Groups.
azurerm_resource_group does NOT support create_before_destroy because name must be globally unique, and Azure doesn’t allow duplicates

# Example (for supported resources like Azure App Service):

resource "azurerm_app_service" "example" {
  name                = "webapp-${random_id.suffix.hex}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  app_service_plan_id = azurerm_app_service_plan.example.id

  lifecycle {
    create_before_destroy = true
  }
}

# 2. prevent_destroy

What It Does:
Prevents a resource from being destroyed accidentally.

Use Case:
Great for critical infrastructure like:

Production Resource Groups

Networking resources (VNETs, firewalls)

Databases

# Example (Azure Resource Group):

resource "azurerm_resource_group" "example" {
  name     = "rg-example"

  location = "East US"

  lifecycle {
    prevent_destroy = true
  }
}

# Behavior:

If you try to run terraform destroy or terraform apply that removes this resource, Terraform will fail with:
Error: Instance cannot be destroyed

# 3. ignore_changes:

What It Does:
Tells Terraform to ignore changes to specific attributes, so it won't try to re-apply them.

Use Case:
Teams update tags manually in Azure Portal

Auto-generated values (like identity)

Allow Ops teams to tweak resources without triggering drift

 Example:

 resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "East US"
  tags = {
    env = "dev"
  }

  lifecycle {
    ignore_changes = [
      tags["owner"]  # Ignore if someone adds or changes this tag manually
    ]
  }
}

Behavior:
If someone adds a tag owner = 'admin' in the portal, Terraform will not overwrite it during future applies.

# 4. precondition (Terraform 1.2+)

What It Does:
Allows you to validate certain conditions before creating the resource. If the condition fails, the plan will fail.

 Use Case:
Enforce naming rules

Validate location

Prevent resource creation in non-approved regions

# Example:
resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "East US"

  lifecycle {
    precondition {
      condition     = contains(["East US", "West Europe"], var.location)
      error_message = "Only East US or West Europe are allowed for Resource Group"
    }
  }
}

Behavior:

If var.location is set to Central US, Terraform will fail with:

Error: Only East US or West Europe are allowed for Resource Group

Summary Table

| Lifecycle Rule          | Supported for `azurerm_resource_group`? | Use Case                                           |
| ----------------------- | --------------------------------------- | -------------------------------------------------- |
| `create_before_destroy` | ❌ Not supported (name must be unique)   | Use with swappable resources (e.g., App Service)   |
| `prevent_destroy`       | ✅ Yes                                   | Protect production or critical infra               |
| `ignore_changes`        | ✅ Yes                                   | Ignore changes made outside Terraform (e.g., tags) |
| `precondition`          | ✅ Yes (Terraform 1.2+)                  | Enforce environment-specific rules                 |

# Full Example with Multiple Rules
resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = var.location
  tags = {
    environment = "dev"
  }

  lifecycle {
    prevent_destroy = true

    ignore_changes = [
      tags["owner"]
    ]

    precondition {
      condition     = contains(["East US", "West Europe"], var.location)
      error_message = "Only East US or West Europe are allowed!"
    }
  }
}

# Real-World Advice

Use prevent_destroy on prod resources

Use ignore_changes when manual edits are expected

Use precondition to enforce environment policies

Avoid create_before_destroy for unique-named Azure resources

