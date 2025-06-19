# Log in to Azure

 az login
 
 # Create Service Principal

 az ad sp create-for-rbac -n az-demo --role="Contributor" --scopes="/subscriptions/$SUBSCRIPTION_ID"

#Note: Use the values generated here to export the variables in the next step

# Set env vars so that the service principal is used for authentication

export ARM_CLIENT_ID=""
export ARM_CLIENT_SECRET=""
export ARM_SUBSCRIPTION_ID=""
export ARM_TENANT_ID=""

-----
alias tf=terraform

--
# Issue

tf plan
╷
│ Error: name ("teststorage_account") can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long      
│
│   with azurerm_storage_account.example,
│   on main.tf line 19, in resource "azurerm_storage_account" "example":
│   19:     name = "teststorage_account"
│
╵-------
# Which resources will be created.
tf plan | grep "will be created"
  # azurerm_resource_group.example will be created
  # azurerm_storage_account.example will be created

# terraform commands

  terraform init
  tf plan
  tf validate
  tf apply 
  tf destroy
  terraform apply --auto-approve
  tf destroy --auto-approve

  # issue 
  Error: creating Storage Account (Subscription: "3f90479e-22ad-4b08-9bf2-3ec64764e205"
│ Resource Group Name: "example_resources"
│ Storage Account Name: "teststorageaccount1"): performing Create: unexpected status 409 (409 Conflict) with error: StorageAccountAlreadyTaken: The storage account named teststorageaccount1 is already taken.

# Explanation:

What This Means

This error is saying:

Azure storage account names must be globally unique (across all Azure customers, not just your subscription).

The name teststorageaccount1 is already used by someone — anywhere in Azure.

Azure responded with 409 Conflict → “already exists globally.”