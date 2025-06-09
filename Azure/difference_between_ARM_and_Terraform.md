# 1.Tools Overview

| Feature                    | **ARM Templates**                           | **Terraform**                          |
| -------------------------- | ------------------------------------------- | -------------------------------------- |
| IaC Language               | JSON                                        | HCL (HashiCorp Configuration Language) |
| Scope                      | Azure-only                                  | Multi-cloud (Azure, AWS, GCP, etc.)    |
| Execution Engine           | Azure Resource Manager                      | Terraform CLI / Cloud                  |
| Resource Lifecycle Support | Add/update only (delete with complete mode) | Add, update, delete (tracked by state) |
| Modularity                 | Limited via nested templates                | Strong support via modules             |
| State Management           | No (stateless)                              | Yes (`.tfstate` file)                  |

# 2.Resource Creation Comparison

| Feature                         | **ARM Templates**          | **Terraform**                              |
| ------------------------------- | -------------------------- | ------------------------------------------ |
| New Resource Addition           | Add resource block in JSON | Add block in `.tf`                         |
| Looping/Iteration               | `copy` (limit: 800)        | `count`, `for_each` (no fixed limit)       |
| Max Resources per Deployment    | 800                        | No hard limit, subject to Azure API limits |
| Nested Deployment Support       | Max 5 levels               | Unlimited via nested modules               |
| Template/Script File Size Limit | 4 MB (compressed)          | No strict limit (depends on environment)   |
| Dependency Handling             | `dependsOn` manually set   | Automatically handles most dependencies    |
| Parallelism                     | Managed by Azure backend   | Configurable (`-parallelism` flag)         |
| Custom Functions                | Limited, JSON-based        | Rich expressions, variables, locals        |

# 3.Resource Deletion Comparison

| Feature                      | **ARM Templates**                                    | **Terraform**                                                |
| ---------------------------- | ---------------------------------------------------- | ------------------------------------------------------------ |
| Resource Deletion by Default | Not automatic (Incremental mode only adds/updates) | Automatic if removed from config + apply                   |
| Deployment Modes             | Incremental (default) / Complete                     | Not applicable (plan/apply handles full lifecycle)           |
| Delete Unused Resources      | Only in **Complete Mode**                            | Automatically on apply                                     |
| Destroy Preview              | Limited (`what-if` is optional)                    | `terraform plan` shows destroy actions                     |
| Manual Deletion Handling     | Must redeploy to re-create if deleted                | Detected as **drift**, shown on next plan                    |
| Resource Renaming Behavior   | Triggers delete + recreate                           | Usually triggers recreate (unless `lifecycle` settings used) |


# 4. Limitations Comparison

| Limitation Category            | **ARM Templates**       | **Terraform**                                    |
| ------------------------------ | ----------------------- | ------------------------------------------------ |
| Max Resources per Template     | 800                     | None (Azure backend limits still apply)          |
| Nested Depth                   | Max 5 levels            | No limit                                         |
| Output Values                  | Max 64 outputs          | No fixed output limit                            |
| Loop Iterations                | Max 800 (`copy`)        | No fixed limit (`count`, `for_each`)             |
| Support for New Azure Services | Immediate upon GA       | May lag until provider supports it               |
| Error Messaging                | Often hard to interpret | More readable with line-by-line diff             |
| Resource Drift Detection       | Not automatic           | Automatically detected via state vs real infra |
| State Management               | No persistent state     | Tracks full resource state (`.tfstate`)        |

# 5. Deletion & Safety Controls:

| Action                         | **ARM Templates**            | **Terraform**                                 |
| ------------------------------ | ---------------------------- | --------------------------------------------- |
| Safe Delete Preview            | Not by default             | `terraform plan` shows changes before apply |
| Accidental Deletion Prevention | Use Incremental Mode       | Review and approve plan before apply        |
| Force Full Delete              | Use Complete Mode          | Use `terraform destroy`                     |
| Controlled Deletion            | No built-in selective delete | Use `target` flag or module isolation       |


# 5. Summary: When to Use What?

| Scenario                                | Use ARM Templates                          | Use Terraform                     |
| --------------------------------------- | ------------------------------------------ | --------------------------------- |
| Azure-only environment                  | Recommended                              | Supported                       |
| Multi-cloud or hybrid environments      | Not supported                            | Best suited                     |
| Need for modular, reusable code         | Difficult (nested templates only)       | Strong module support           |
| Managing full resource lifecycle (CRUD) | Requires manual delete or Complete Mode | Automatically handles lifecycle |
| Preventing accidental deletions         | Use Incremental Mode                     | Review `terraform plan`         |
| Simple, small-scale deployments         | Suitable                                 | Suitable                        |


