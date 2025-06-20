#!/bin/bash
set -e  # Exit if any command fails

# ==== CONFIGURATION VARIABLES ====
RESOURCE_GROUP="StaticWebsiteRG"
LOCATION="eastus"
VM_NAME="StaticWebVM"
IMAGE="Ubuntu2204"
ADMIN_USERNAME="azureuser"
VM_SIZE="Standard_B1s"
SSH_KEY_PATH="$HOME/.ssh/id_rsa.pub"

# ==== STEP 1: CREATE RESOURCE GROUP ====
echo "Creating resource group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# ==== STEP 2: CREATE VIRTUAL MACHINE ====
echo "Creating virtual machine..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --image $IMAGE \
  --size $VM_SIZE \
  --admin-username $ADMIN_USERNAME \
  --authentication-type ssh \
  --ssh-key-values "$SSH_KEY_PATH" \
  --output none

# ==== STEP 3: OPEN PORT 80 ====
echo "Opening port 80 for web traffic..."
az vm open-port --port 80 --resource-group $RESOURCE_GROUP --name $VM_NAME --output none

# ==== STEP 4: INSTALL NGINX AND COPY FILES ====
PUBLIC_IP=$(az vm show \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --show-details \
  --query publicIps \
  --output tsv)

echo "Waiting for VM to initialize..."
sleep 30

echo "Installing NGINX on remote VM..."
ssh -o StrictHostKeyChecking=no $ADMIN_USERNAME@$PUBLIC_IP << 'EOF'
  sudo apt update
  sudo apt install -y nginx
EOF

# ==== STEP 5: COPY STATIC FILES ====
echo "Copying static files to VM..."
scp -r DevFolio/* $ADMIN_USERNAME@$PUBLIC_IP:/tmp/

ssh $ADMIN_USERNAME@$PUBLIC_IP << 'EOF'
  sudo cp -r /tmp/* /var/www/html/
  sudo systemctl restart nginx
EOF

# ==== DONE ====
echo "Deployment complete!"
echo "Visit your site at: http://$PUBLIC_IP"
