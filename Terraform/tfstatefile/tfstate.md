# What is Terraform State?

Terraform uses a state file (terraform.tfstate) to track the infrastructure it manages.

This file stores:

What resources have been created

Their current configuration

Metadata (e.g., resource IDs, dependencies)

# Why is it Important?

Terraform needs to know what exists in your environment so it can:

Know what to create/update/delete

Show accurate plans before applying

Perform refresh and drift detection

# Desired State vs. Actual State

| Term              | Meaning                                                                 |
| ----------------- | ----------------------------------------------------------------------- |
| **Desired State** | What’s written in your `.tf` files (what you want infrastructure to be) |
| **Actual State**  | What actually exists in the cloud/provider environment                  |

# Types of Terraform State

1.Local State (default)

Stored in terraform.tfstate file locally

2. Remote State (recommended for teams)

Stored in Azure Blob, S3, Terraform Cloud, etc.

Supports locking, versioning, and collaboration

# Advantages of Terraform State

| Advantage                           | Description                                                                  |
| ----------------------------------- | ---------------------------------------------------------------------------- |
|  Tracks resource metadata         | Stores resource IDs, dependencies, and outputs                               |
| Enables incremental updates      | Terraform knows what changed and only modifies the diff                      |
|  Supports team collaboration      | Remote state backends allow multiple team members to work safely             |
|  Detects configuration drift  | Helps spot differences between infra and code using `terraform plan/refresh` |
|  Enables outputs and dependencies | State holds values that can be passed between modules or scripts             |

# Tips

store state file in remote backend (blob,s3,gcp storage)

donot delete / update the file

state locking

isolation of state file

remote locking.

# Disadvantages / Risks

| Disadvantage                           | Description                                                                         |
| -------------------------------------- | ----------------------------------------------------------------------------------- |
| Sensitive data exposure             | Secrets (like keys, passwords) may be stored in plaintext in the `.tfstate`         |
| Manual editing is risky             | Modifying the state file can corrupt your infrastructure mapping                    |
| Drift risk if state isn't refreshed | Changes made **outside of Terraform** (manual Azure portal changes) can cause drift |
| Local state not safe for teams      | Conflicts and overwrites possible if not using remote state with locking            |

# Best Practices

Use remote state for team projects (e.g., Azure Blob backend)

Enable state locking (Azure supports it via blob lease)

Never commit terraform.tfstate to Git

Protect sensitive data with state encryption

Run terraform refresh before plan if changes may have been made outside Terraform

# Rg creation
az group create --name tfstate-day04 --location eastus

# Storage Account creation

az storage account create --resource-group tfstate-day04 --name day04$RANDOM --sku Standard_LRS --encryption-services blob
