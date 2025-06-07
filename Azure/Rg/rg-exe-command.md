az deployment sub create \
  --location eastus \
  --template-file rg-template.json \
  --parameters rgName=DevRG rgLocation=eastus

  --------------
# Delete a Resource Group (using Azure CLI )

  az group delete --name DevRG --yes --no-wait

-----------------
az deployment group create \
  --resource-group DevRg \
  --template-file ubuntu-vm-template.json \
  --parameters adminPassword=Welcome@1234

----------------
# Typical ARM Template Resources Section (Summary)

"resources": [
  // 1. Virtual Network
  // 2. Network Security Group
  // 3. Public IP Address
  // 4. Network Interface
  // 5. Virtual Machine
]

-------------
# Components Created in a Typical Ubuntu VM Deployment (via ARM Template)

| Component                                      | Resource Type                             | Description                                                      |
| ---------------------------------------------- | ----------------------------------------- | ---------------------------------------------------------------- |
| **1. Virtual Machine (VM)**                    | `Microsoft.Compute/virtualMachines`       | The Ubuntu VM itself (e.g., OS, size, disk, NIC attached).       |
| **2. Network Interface (NIC)**                 | `Microsoft.Network/networkInterfaces`     | Acts as the network card for the VM; connects VM to VNet/subnet. |
| **3. Public IP Address**                       | `Microsoft.Network/publicIPAddresses`     | Optional – gives the VM internet access.                         |
| **4. Virtual Network (VNet)**                  | `Microsoft.Network/virtualNetworks`       | Provides networking space for the VM (subnet included).          |
| **5. Network Security Group (NSG)**            | `Microsoft.Network/networkSecurityGroups` | Controls inbound/outbound traffic (e.g., allow SSH).             |
| **6. OS Disk**                                 | `Microsoft.Compute/disks`                 | Managed disk that stores the Ubuntu OS.                          |
| **7. Availability Set** *(optional)*           | `Microsoft.Compute/availabilitySets`      | For high availability (not always included).                     |
| **8. Diagnostic Storage Account** *(optional)* | `Microsoft.Storage/storageAccounts`       | If boot diagnostics or monitoring is enabled.                    |

