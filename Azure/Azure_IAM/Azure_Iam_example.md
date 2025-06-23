# What is Azure IAM?

Azure IAM stands for Azure Identity and Access Management.

It is a framework used to control who can access what resources in Azure, and what they can do with them.

# In simple terms:

"IAM ensures the right people have the right access to the right Azure resources."

# Core Components of Azure IAM:

| Component              | Description                                                               |
| ---------------------- | ------------------------------------------------------------------------- |
| **Users**              | Human users (developers, testers, admins, etc.)                           |
| **Groups**             | Collection of users (e.g., Dev Team, QA Team)                             |
| **Roles**              | A set of permissions (e.g., Reader, Contributor, Owner)                   |
| **Role Assignments**   | Binds a **user/group** with a **role** on a specific **resource**         |
| **Service Principals** | Non-human identity (like apps or automation scripts)                      |
| **RBAC**               | Role-Based Access Control — the main way permissions are granted in Azure |

# Example: Azure IAM in a Project:

Scenario:

You are working in a DevOps team deploying a .NET application to Azure.

Your team:

Developer (Dev) needs access to deploy code.

Tester needs read-only access to validate resources.

App (CI/CD Pipeline) needs access to deploy via Azure DevOps.

# Step-by-step using IAM:

| Step | Task                        | IAM Implementation                                                |
| ---- | --------------------------- | ----------------------------------------------------------------- |
| 1    | **Create Azure Resources**  | Resource Group, App Service, Key Vault                            |
| 2    | **Add Developer**           | Assign **Contributor** role on the Resource Group                 |
| 3    | **Add Tester**              | Assign **Reader** role on the Resource Group                      |
| 4    | **Create App Registration** | Create **Service Principal** in Azure AD                          |
| 5    | **Assign Role to App**      | Assign **Contributor** role to Service Principal for CI/CD access |

 
# IAM in Action

# Developer:

Can deploy, edit settings, restart services.

Cannot delete the entire subscription.

# Tester:

Can view logs, metrics, and settings.

Cannot modify or deploy.

# CI/CD Pipeline:

Azure DevOps pipeline authenticates using a Service Principal with Contributor role.

Deploys application code securely without exposing credentials.

# IAM Scope Levels in Azure

| Scope              | Example                                        |
| ------------------ | ---------------------------------------------- |
| **Subscription**   | All resources in a subscription                |
| **Resource Group** | Group of resources (App + DB)                  |
| **Resource**       | Individual resource (like one VM or Key Vault) |

# Summary

| Feature   | Description                                                                         |
| --------- | ----------------------------------------------------------------------------------- |
| Azure IAM | Controls access to Azure resources                                                  |
| Key Tool  | RBAC (Role-Based Access Control)                                                    |
| Real Use  | Manage access for users, groups, apps                                               |
| Example   | Dev = Contributor, Tester = Reader, CI/CD = Service Principal with Contributor role |

# Note:

Azure IAM (Authentication + Authorization) =Users (Roles+Groups)  Resources=(Service Principle+Managed Identity Principle)

Authentication verifies the identity (e.g., user, service principal, managed identity).

Authorization determines what an authenticated identity can access or modify.

# Difference: Authentication vs Authorization:

| Term               | Purpose                                       | Simple Meaning                        |
| ------------------ | --------------------------------------------- | ------------------------------------- |
| **Authentication** | Prove **who you are** (identity verification) | "Are you really who you say you are?" |
| **Authorization**  | Decide **what you can access/do**             | "What are you allowed to do?"         |

# Azure IAM – Authentication vs Authorization Components

# Authentication Services (WHO you are)

These services are responsible for verifying identity.

| Azure Service                         | Description                                                         |
| ------------------------------------- | ------------------------------------------------------------------- |
| **Azure Active Directory (Azure AD)** | Main identity provider (IdP) in Azure for users, groups, apps, etc. |
| **Azure AD B2C / B2B**                | External user authentication (e.g., customers, partners)            |
| **Managed Identity**                  | Automatically provides identities to apps/services without secrets  |
| **Service Principal**                 | Identity for applications to authenticate to Azure                  |

# Authentication flow example:

A developer logs into the Azure Portal using their credentials (verified via Azure AD).

An Azure DevOps pipeline authenticates to Azure using a service principal with a secret/certificate.

# Authorization Services (WHAT you can do)

These services are used to grant/restrict access to resources after authentication.

| Azure Service                        | Description                                                                |
| ------------------------------------ | -------------------------------------------------------------------------- |
| **Role-Based Access Control (RBAC)** | Controls access based on assigned roles (Reader, Contributor, Owner, etc.) |
| **Azure Policy**                     | Enforces rules and conditions on resources (e.g., no public IPs)           |
| **Custom Roles**                     | Custom permissions tailored to exact needs                                 |
| **Resource Locks & Tags**            | Controls actions like deletion (additional layer)                          |

# Authorization flow example:

After login, the system checks what role assignments you have.

If you're a Reader, you can only view.

If you're a Contributor, you can modify resources.

# Example

| Scenario                                           | Authentication                              | Authorization                                      |
| -------------------------------------------------- | ------------------------------------------- | -------------------------------------------------- |
| A tester logs into Azure Portal                    | Verified by **Azure AD**                    | Allowed to **view** resources by **Reader role**   |
| Azure DevOps deploys app using a service principal | SPN is authenticated using credentials/cert | It’s granted **Contributor** on the resource group |


# Summary Table

| Category           | Azure Services                                         |
| ------------------ | ------------------------------------------------------ |
| **Authentication** | Azure AD, B2C/B2B, Managed Identity, Service Principal |
| **Authorization**  | Azure RBAC, Azure Policy, Custom Roles, Resource Locks |


# What is a Service Principal in Azure?

A Service Principal (SP) is a security identity used by applications, scripts, and tools to access Azure resources.

# Think of it like:

A "username/password or certificate" for an app to log in to Azure.

# Where is it used?

CI/CD pipelines (e.g., Azure DevOps, GitHub Actions)

Terraform, Ansible, and scripts to deploy resources

Apps needing access to Azure Key Vault, Storage, etc.

# How to Create a Service Principal (Azure CLI)

az ad sp create-for-rbac --name myApp --role Contributor --scopes /subscriptions/<your-subscription-id>


Output:

{
  "appId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "displayName": "myApp",
  "password": "xxxxx~secret~xxxxx",
  "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

appId: Client ID

password: Client Secret

tenant: Tenant ID

You use these values to authenticate your app or tool (like Terraform).

# What is Managed Identity?

A Managed Identity (MI) is an automated version of a Service Principal, created and managed by Azure for you.

Think of it like:

A built-in identity that your Azure resources (VMs, App Services, Functions) can use to authenticate to other Azure services without secrets.

# Key Benefits:

| Feature              | Service Principal | Managed Identity            |
| -------------------- | ----------------- | --------------------------- |
| Needs manual secret? | ✅ Yes             | ❌ No                        |
| Secret rotation?     | Manual            | Automatic                   |
| Works outside Azure? | ✅ Yes             | ❌ No (only Azure resources) |
| Setup Complexity     | Medium            | Very Easy                   |

# Types of Managed Identities

| Type                | Description                                              |
| ------------------- | -------------------------------------------------------- |
| **System-assigned** | Tied to a single Azure resource (like VM or App Service) |
| **User-assigned**   | Reusable identity across multiple resources              |

# How to Enable Managed Identity (Example: VM)

az vm identity assign --name myVM --resource-group myRG

# Example Use Case: Access Key Vault from Azure VM

Step 1: Enable Managed Identity on VM

az vm identity assign --name myVM --resource-group myRG

Step 2: Give Key Vault permission to that VM identity

az keyvault set-policy \
  --name myKeyVault \
  --object-id <vm-identity-object-id> \
  --secret-permissions get list

  Step 3: From inside the VM, access Key Vault

curl 'http://169.254.169.254/metadata/identity/oauth2/token?resource=https://vault.azure.net' -H Metadata:true

# Summary

| Feature          | Service Principal                   | Managed Identity                          |
| ---------------- | ----------------------------------- | ----------------------------------------- |
| Purpose          | App/script authentication to Azure  | Azure resource identity (no secrets)      |
| Secret Required? | ✅ Yes                               | ❌ No                                      |
| Best for         | External tools (Terraform, scripts) | Internal Azure resources (VMs, Functions) |
| Setup            | Manual                              | Automatic (simple toggle)                 |

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# What is Azure Key Vault?

Azure Key Vault is a cloud-based service provided by Microsoft Azure to securely store and manage sensitive information such as:

Secrets (e.g., passwords, API keys, connection strings)

Keys (e.g., encryption keys, signing keys)

Certificates (e.g., SSL/TLS certificates)

# Why Use Key Vault?

Instead of hardcoding secrets in your code or storing them in config files, Key Vault lets you securely store and retrieve them with access control.

# Key Vault Components

| Component                | Description                                                  |
| ------------------------ | ------------------------------------------------------------ |
| **Secrets**              | Store text values like passwords, tokens, connection strings |
| **Keys**                 | Cryptographic keys (used for encryption, signing)            |
| **Certificates**         | SSL/TLS certs managed or imported                            |
| **Access Policies/RBAC** | Controls who/what can access Key Vault items                 |

# Where is Azure Key Vault Used?

1. Store secrets for applications

E.g., instead of storing a DB password in your app’s config file:

Store it in Key Vault

App retrieves it securely at runtime

2. Azure DevOps or GitHub Actions

Store secure variables (like SPN client secrets) in Key Vault

Pipelines access them securely without exposing in code

3. TLS/SSL Certificates Management

Automatically renew and manage SSL certs for websites (App Services)

4. Disk Encryption

Use customer-managed keys from Key Vault for encrypting Azure Storage, Disks, etc.

5. Key Management for Apps

Use cryptographic keys stored in Key Vault to encrypt/decrypt sensitive data in your app

# Real-World Example

Scenario:

You have a web app that connects to Azure SQL Database.

Problem:

You don’t want to hardcode the DB connection string or password.

Solution:

Store the DB connection string as a secret in Azure Key Vault.

Grant the App Service access using Managed Identity.

Your app securely pulls the secret from Key Vault at runtime.

# Example: Store and Retrieve a Secret using Azure CLI

Step 1: Create a Key Vault

az keyvault create --name myKeyVault --resource-group myRG --location eastus

Step 2: Store a secret

az keyvault secret set --vault-name myKeyVault --name "DbPassword" --value "MySuperSecretP@ssword"

Step 3: Retrieve the secret

az keyvault secret show --vault-name myKeyVault --name "DbPassword" --query value

# How Access is Managed

Key Vault supports two access control models:

| Component                | Description                                                  |
| ------------------------ | ------------------------------------------------------------ |
| **Secrets**              | Store text values like passwords, tokens, connection strings |
| **Keys**                 | Cryptographic keys (used for encryption, signing)            |
| **Certificates**         | SSL/TLS certs managed or imported                            |
| **Access Policies/RBAC** | Controls who/what can access Key Vault items                 |

# Where is Azure Key Vault Used?

1. Store secrets for applications

E.g., instead of storing a DB password in your app’s config file:

Store it in Key Vault

App retrieves it securely at runtime

2. Azure DevOps or GitHub Actions

Store secure variables (like SPN client secrets) in Key Vault

Pipelines access them securely without exposing in code

3. TLS/SSL Certificates Management

Automatically renew and manage SSL certs for websites (App Services)

4. Disk Encryption

Use customer-managed keys from Key Vault for encrypting Azure Storage, Disks, etc.

5. Key Management for Apps

Use cryptographic keys stored in Key Vault to encrypt/decrypt sensitive data in your app

# Real-World Example

Scenario:

You have a web app that connects to Azure SQL Database.

Problem:

You don’t want to hardcode the DB connection string or password.

Solution:

Store the DB connection string as a secret in Azure Key Vault.

Grant the App Service access using Managed Identity.

Your app securely pulls the secret from Key Vault at runtime.

# Example: Store and Retrieve a Secret using Azure CLI

Step 1: Create a Key Vault

az keyvault create --name myKeyVault --resource-group myRG --location eastus

Step 2: Store a secret

az keyvault secret set --vault-name myKeyVault --name "DbPassword" --value "MySuperSecretP@ssword"

Step 3: Retrieve the secret

az keyvault secret show --vault-name myKeyVault --name "DbPassword" --query value

# How Access is Managed

Key Vault supports two access control models:

| Model                  | Description                                                  |
| ---------------------- | ------------------------------------------------------------ |
| **Access Policies**    | Old model (add users/apps and set specific permissions)      |
| **RBAC (Recommended)** | Uses Azure RBAC to control access, integrates with Azure IAM |

# Summary

| Feature            | Description                                       |
| ------------------ | ------------------------------------------------- |
| **Purpose**        | Securely store/manage secrets, keys, certificates |
| **Used in**        | Apps, pipelines, VM encryption, certificate mgmt  |
| **Access control** | IAM (RBAC) or Access Policies                     |
| **Secure benefit** | Avoid storing secrets in code or files            |


# In Microsoft Entra ID (formerly Azure AD), when you create a group, you’ll see two group types:

Two Group Types in Microsoft Entra ID / Azure AD

| Group Type              | Description                                                                                  |
| ----------------------- | -------------------------------------------------------------------------------------------- |
| **Security Group**      | Used to **manage access to resources** (e.g., VMs, storage, apps, Azure roles)               |
| **Microsoft 365 Group** | Used for **collaboration**, comes with **shared mailbox, calendar, SharePoint, Teams, etc.** |

# Security Group

Usage:

Access control (IAM) in Azure (e.g., assign RBAC roles)

Control access to:

Virtual Machines

Azure Key Vault

Storage Accounts

Applications (Enterprise Apps)

Conditional Access policies

Used in on-prem AD and Azure AD

# When to Use:

You want to assign roles to a group of users or service principals

You don’t need collaboration tools

Used by IT admins, DevOps, and Security teams

# 2. Microsoft 365 Group (formerly Office 365 Group)

 Usage:

Collaboration group tied to Microsoft 365 services

When you create one, it includes:

Outlook Shared Mailbox

SharePoint site

Microsoft Teams workspace

Planner

Calendar

# When to Use:

Teams working on a project, department, or shared communication

You want users to collaborate using email, Teams, SharePoint, etc.

Auto-managed through Microsoft 365 admin tools

# Admin Tip:

Use Security groups for technical/administrative control (Azure roles, app access)

Use Microsoft 365 groups for collaborative teams using email, Teams, and docum

# Step 1: Create a New User in Azure

Login to https://portal.azure.com

On the left menu or search Microsoft Entra ID, click on “Microsoft Entra ID” (this is the new name for Azure AD)

Click on “Users”

Click “+ New user”

Fill in the form:

User name: devuser1

Name: Developer User

Let Microsoft create password

Click “Review + Create” → “Create”

copy+Paste (Autogenerated password)

# Step 2: Create a Group

Still inside Microsoft Entra ID, go back to the left menu

Click on “Groups”

Click “+ New group”

Fill in:

Group type: Security

Group name: DeveloperGroup

Membership type: Assigned

Click “Create”

# Step 3: Add User to the Group

After group is created, click on the DeveloperGroup

Click “Members” on the left menu

Click “+ Add members”

Search for the user (e.g., devuser1)

Select and click “Select”

# Step 4: Assign Permissions (RBAC Role) to the Group

Let’s say you want this group to manage a resource group in Azure (for example, DevRG).

Go to the Resource Group:

In the left menu of the Azure Portal, click “Resource groups”

Select your target group, for example DevRG

Assign Role:

Inside the DevRG page, click “Access control (IAM)” in the left menu

Click “+ Add” → “Add role assignment”

Choose a Role:

For DeveloperGroup: select Contributor

Click Next

Under Members, click + Select members

Search and select your DeveloperGroup

Click Select → Review + assign

# Summary

| Step | What You Did        | Azure Portal Location                 |
| ---- | ------------------- | ------------------------------------- |
| 1    | Created user        | Microsoft Entra ID → Users            |
| 2    | Created group       | Microsoft Entra ID → Groups           |
| 3    | Added user to group | Groups → \[Your Group] → Members      |
| 4    | Assigned RBAC role  | Resource Group → Access control (IAM) |



ARM deployment commands:

az deployment sub create \
  --location eastus \
  --template-file rg-template.json \
  --parameters rgName=DevRG rgLocation=eastus

