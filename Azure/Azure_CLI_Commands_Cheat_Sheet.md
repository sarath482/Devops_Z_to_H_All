 # Azure CLI Commands Cheat Sheet

 az login

Login to your Azure account (opens browser for authentication).

 az account show

Show details of the current logged-in Azure account.

 az account list --output table

 List all Azure subscriptions in a table format.

 az account set --subscription <name/id>

Set the active subscription to use.

az group create --name <rg> --location <loc>

Create a resource group in specified location.

az group list --output table

List all resource groups.

az group delete --name <rg> --yes

Delete a resource group and all resources inside it.

az vm create --resource-group <rg> --name <vm> --image <img> --admin-username <user> --generate-ssh-keys

Create a Linux VM with SSH keys.

az vm list --output table

List all virtual machines.

az vm start --resource-group <rg> --name <vm>

Start a virtual machine.

az vm stop --resource-group <rg> --name <vm>

Stop a virtual machine.

az vm restart --resource-group <rg> --name <vm>

Restart a virtual machine.

az resource show --name <res> --resource-group <rg> --resource-type <type>

Show details of a resource.

az storage account list --output table

List all storage accounts.

az storage account create --name <name> --resource-group <rg> --location <loc> --sku Standard_LRS

Create a new storage account.

az storage blob upload --account-name <acct> --container-name <cont> --name <blobname> --file <path>

Upload a file to Azure Blob Storage.

az network vnet create --resource-group <rg> --name <vnetname> --address-prefix <cidr>

Create a Virtual Network (VNet).

az network nsg create --resource-group <rg> --name <nsgname>

Create a Network Security Group (NSG).

az network nsg rule create --resource-group <rg> --nsg-name <nsgname> --name <rulename> --protocol Tcp--direction Inbound 

--priority 100 --source-address-prefixes '*' --source-port-ranges '*'--destination-address-prefixes '*' 

--destination-port-ranges 22 --access Allow

Create an NSG rule (example: allow SSH).

az aks create --resource-group <rg> --name <clustername> --node-count 3 --enable-addons monitoring--generate-ssh-keys

Create an AKS (Azure Kubernetes Service) cluster.

az aks get-credentials --resource-group <rg> --name <clustername>

Get AKS cluster credentials to connect kubectl.

az functionapp create --resource-group <rg> --consumption-plan-location <loc> --runtime <runtime> --name

<appname> --storage-account <acct>

Create an Azure Function app.

az webapp create --resource-group <rg> --plan <appserviceplan> --name <appname> --runtime <runtime>

Create an Azure Web App.

az monitor log-analytics workspace create --resource-group <rg> --workspace-name <wsname> --location <loc>

Create a Log Analytics workspace.

az tag create --resource-id <resourceId> --tags key1=value1 key2=value2

Add tags to an Azure resource.

az logout

Log out of Azure CLI session