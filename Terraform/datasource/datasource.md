# What is a Terraform Data Source?

A data source in Terraform allows you to fetch information (read-only) from external sources or existing infrastructure that you did not create in your Terraform configuration.

Think of it as: "read-only lookups" for resources you want to reference — not create.

# When & Where to Use Data Sources

| Use Case                               | Why Use Data Source?                                                                      |
| -------------------------------------- | ----------------------------------------------------------------------------------------- |
| Reference existing infrastructure      | When a resource like a VNet, subnet, or Key Vault already exists and is managed elsewhere |
| Lookup shared resource values          | Reuse values like AMI IDs, security groups, secrets, etc.                                 |
| Dependency from other teams or modules | Read output of another resource managed in a different module or workspace                |
| Dynamic values based on cloud provider | Get current region, account info, IP, etc.                                                |


# Prerequisites for executing the scripts:

In the Azure portal, I created a resource group named shared-network-rg, a virtual network (shared-network-vnet), and a subnet (shared-primary-sn) within that VNet. After completing these steps, you can proceed to execute the Terraform script.

# issue:
Plan: 1 to add, 0 to change, 0 to destroy.
╷
│ Error: Virtual Network (Subscription: "3f90479e-22ad-4b08-9bf2-3ec64764e205"
│ Resource Group Name: "shared-network-rg"
│ Virtual Network Name: "shared-network-rg") was not found
│
│   with data.azurerm_virtual_network.vnet_shared,
│   on main.tf line 9, in data "azurerm_virtual_network" "vnet_shared":
│    9: data "azurerm_virtual_network" "vnet_shared" {
│
╵
Releasing state lock. This may take a few moments...

Solution : vnet name updated

# Note : The creation of resources

terraform plan | grep "will be created"
  # azurerm_network_interface.main will be created
  # azurerm_resource_group.example will be created
  # azurerm_virtual_machine.main will be created
