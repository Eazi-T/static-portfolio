#!/bin/bash

# Variables
RESOURCE_GROUP="StaticWebsiteRG"
LOCATION="eastus"
VM_NAME="staticvm"
ADMIN_USERNAME="azureuser"
ADMIN_PASSWORD="Eazi2000@"  # CHANGE THIS to something secure!
VM_IMAGE="Ubuntu2204"
VM_SIZE="Standard_B1s"

# Create resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create VM with password auth
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --image $VM_IMAGE \
  --admin-username $ADMIN_USERNAME \
  --admin-password $ADMIN_PASSWORD \
  --authentication-type password \
  --size $VM_SIZE \
  --output none

# Open port 80
az vm open-port --port 80 --resource-group $RESOURCE_GROUP --name $VM_NAME --output none

# Get VM public IP
IP=$(az vm show -d -g $RESOURCE_GROUP -n $VM_NAME --query publicIps -o tsv)
echo "VM Public IP: $IP"

# Install NGINX remotely
sshpass -p $ADMIN_PASSWORD ssh -o StrictHostKeyChecking=no $ADMIN_USERNAME@$IP << 'EOF'
  sudo apt update
  sudo apt install -y nginx
EOF

# Copy site files to VM
sshpass -p $ADMIN_PASSWORD scp -o StrictHostKeyChecking=no -r ./DevFolio/* $ADMIN_USERNAME@$IP:/tmp/

# Move files into NGINX root
sshpass -p $ADMIN_PASSWORD ssh -o StrictHostKeyChecking=no $ADMIN_USERNAME@$IP << 'EOF'
  sudo cp -r /tmp/* /var/www/html/
EOF

echo "✅ Deployment complete. Visit http://$IP"
