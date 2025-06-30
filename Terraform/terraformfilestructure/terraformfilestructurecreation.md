# After running terraform init, it becomes:

terraform init

my-terraform-project/
├── main.tf
├── variables.tf
├── outputs.tf
├── .terraform/                      <-- (Hidden folder)
│   ├── providers/                  <-- Downloaded providers
│   │   └── registry.terraform.io/
│   │       └── hashicorp/
│   │           └── azurerm/
│   │               └── x.y.z/       <-- Versioned provider
│   ├── modules/                    <-- (if using modules)
│   └── terraform.tfstate.d/        <-- (if using workspaces)
├── .terraform.lock.hcl             <-- Lock file for provider versions

# Details of Each Item

| Item                              | Purpose                                                                                        |
| --------------------------------- | ---------------------------------------------------------------------------------------------- |
| `.terraform/`                     | Stores provider plugins, module caches, backend info                                           |
| `.terraform/providers/`           | Where Terraform downloads providers (like `azurerm`, `aws`)                                    |
| `.terraform/modules/`             | Caches reused modules if you're using them                                                     |
| `.terraform/terraform.tfstate.d/` | Stores workspace-specific state data                                                           |
| `.terraform.lock.hcl`             | **Lock file** that records exact versions of providers used (ensures consistency across teams) |

# Important Notes

Do not delete .terraform/ manually unless you want to re-init.

The lock file (.terraform.lock.hcl) ensures your team uses the same provider version, even if newer ones are released.

This doesn't create any *.tfstate files yet — that happens on terraform apply.

# Q: What happens during terraform init?

"terraform init initializes the working directory by downloading required provider plugins, setting up the backend, and preparing module code. It creates a .terraform/ directory and a .terraform.lock.hcl file to manage provider versions."



# Terraform apply

# File and Folder Structure After terraform apply

Assuming you're in a simple local setup (local backend, no workspaces), your folder will now look like:

my-terraform-project/
├── main.tf                     # Your resource definitions
├── variables.tf                # Input variable definitions
├── outputs.tf                  # Output values
├── terraform.tfstate           # The current state of your infrastructure (JSON format)
├── terraform.tfstate.backup    # Backup of the previous state (before last apply)
├── .terraform/                 # Internal Terraform files
│   ├── providers/              # Downloaded providers (like azurerm)
│   ├── modules/                # Cached modules (if used)
│   └── terraform.tfstate.d/    # Workspace-specific state (if using workspaces)
├── .terraform.lock.hcl         # Provider version lock file


# New Files Created/Updated After terraform apply

| File/Folders               | Purpose                                                                            |
| -------------------------- | ---------------------------------------------------------------------------------- |
| `terraform.tfstate`        | Main state file: Tracks resources deployed. Essential for future `plan`/`apply`. |
| `terraform.tfstate.backup` | Backup of the previous state (in case you need rollback).                       |
| `.terraform/`              | Cache and metadata (like providers and modules).                                   |
| `.terraform.lock.hcl`      | Ensures everyone uses the same provider version (created during `init`).           |


# What's Inside terraform.tfstate?

It’s a JSON file containing:

Resource names, IDs, and attributes

Outputs

Provider info

Dependencies

⚠️ It may contain sensitive data — never commit it to GitHub!

# After terraform apply:

my-terraform-project/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfstate             <-- NEW/UPDATED
├── terraform.tfstate.backup      <-- NEW/UPDATED (previous state)
├── .terraform/
│   ├── providers/
│   └── terraform.tfstate.d/      <-- Only if workspaces used
├── .terraform.lock.hcl

# Q: What does terraform apply generate locally?

A: It generates or updates terraform.tfstate to record the current infrastructure state and terraform.tfstate.backup as a rollback copy. These files are critical for tracking and managing future changes.

