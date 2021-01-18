# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
In this project, I have coded a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure. The template is customizable because it is very generic for anyone to clone this repo and provide user specific arguments like subscription id, client id and secret to deploy the web server. The project is scalable , so the user can configure the number of virtual machines as per their need during the deployment.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
1. Create Azure credentials
      - Create a service principal with ``az ad sp create-for-rbac`` and output the credentials
      - Use the command ``az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"``
      - Replace the client_id , client_secret and tenent_id in the [webserver.json](https://github.com/arunprakashpj/Azure-Infrastructure-Operations-Project/blob/master/Packer/webserver.json)
      
2. Customizing and scaling the webserver
      - The variable ``num_of_vms`` is set to default as 2 at [variable.tf](https://github.com/arunprakashpj/Azure-Infrastructure-Operations-Project/blob/master/terraform/variables.tf). It is scalable, thus feel free to change the number as per your requirement.
      - Other variables like ``packer_image_name``,``packer_resource_group``,``tags``,``resource_group``,``location`` can also be configured in this file.
      
3. Create and deploy a policy definition to deny the creation of resources that donot have tags 
      - Create the Azure policy definition by running the shell script ``create_az_policy_definition.sh``
      - Assign the policy definition using the Azure portal
      - Verify the created policy via the Azure CLI using the command ``az policy assignment list``
   
4. Create a server image using packer
      - Create an image resource group named PolicyRG by ``az group create --location northeurope --name PolicyRG``
      - Use the required fields in packer template file   [webserver.json](https://github.com/arunprakashpj/Udacity-Azure-Cloud-DevOps/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/Packer/webserver.json)  
      - Build the packer image using the command ``packer build webserver.json``
      - Use ``az image list`` to list out the images present
      - Use ``az image delete -g packer-rg -n myPackerImage`` to delete any existing packer image
      
5. Create the infrastructure using terraform
      - Create a terraform file  [main.tf](https://github.com/arunprakashpj/Udacity-Azure-Cloud-DevOps/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/terraform/main.tf) and [variable.tf](https://github.com/arunprakashpj/Udacity-Azure-Cloud-DevOps/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/terraform/variables.tf)
      - Create a Resource Group
      - Create a virtual network and a subnet on the virtual network
      - Create a Network Security Group
      - Create a Network Interface
      - Create a Public IP
      - Create a Load Balancer
      - Create a virtual machine availability set
      - Create virtual machines. Make sure you use the image you deployed using packer
      - Create managed disks for your virtual machines
      - Ensure declarative configuration is possible by using  [variable.tf](https://github.com/arunprakashpj/Udacity-Azure-Cloud-DevOps/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/terraform/variables.tf) file
      
 6. Deploy all Azure resources
      - Initializa the terraform using the command ``terraform init``
      - See the plan by using the command ``terraform plan -out solution.plan``
      - Apply the deployment using ``terraform apply``
 
 7. Deploy all Azure resources
      - Destroy all the resources created by terraform using the command ``terraform destroy``
      - Destroy the image built by the packer using the command ``az image delete -g PolicyRG -n webserverPackerImage``
     
      


### Output
Below is the screenshot showing the image created by packer
![Screenshot](https://github.com/arunprakashpj/Udacity-Azure-Cloud-DevOps/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/Screenshots/Building_Packer_Image.png)


Below is the screenshot taken after running ``terraform plan -out solution.plan``
![Screenshot](https://github.com/arunprakashpj/Udacity-Azure-Cloud-DevOps/blob/master/C1%20-%20Azure%20Infrastructure%20Operations/project/starter_files/Screenshots/Terraform_Apply.png)


