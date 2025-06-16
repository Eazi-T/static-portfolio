# 🌐 Azure Static Website Deployment (Capstone Project)

This project automates the deployment of a static website to a virtual machine hosted on Microsoft Azure. It uses a Bash provisioning script and GitHub Actions to set up infrastructure, install NGINX, and serve your site with zero manual steps.

## 🚀 What It Does
- Provisions a Linux VM on Azure
- Installs and configures NGINX
- Copies your static website files (HTML/CSS/JS)
- Automates everything with a GitHub Actions workflow

## 📁 Project Structure

Capstone Project/
├── DevFolio/
│   ├── index.html
│   ├── css/
│   ├── js/
│   └── assets/
├── deploy.sh
├── README.md
└── .github/
    └── workflows/
        └── deploy.yml

## ⚙️ Technologies Used

- **Azure VM (Ubuntu 22.04)**
- **NGINX Web Server**
- **GitHub Actions** for CI/CD
- **Bash scripting** for provisioning


## 🔧 Prerequisites
- An Azure subscription
- GitHub repo with the following secrets configured:
  - `AZURE_CLIENT_ID`
  - `AZURE_CLIENT_SECRET`
  - `AZURE_TENANT_ID`
  - `AZURE_SUBSCRIPTION_ID`
  - `SSH_PRIVATE_KEY` (PEM format, private key)
  - `SSH_PUBLIC_KEY` (must match VM public key)

## 📦 Setup Instructions

### ✅ 1. Generate SSH Keys
  ```bash
  ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa_azure
  ssh-keygen -p -m PEM -f ~/.ssh/id_rsa_azure
  ```
### ✅ 2. Push Code to Main Branch
Once you push to main, the GitHub Actions workflow kicks in automatically:
- Builds resource group and VM
- sets up web server
- Deploys your static site to /var/www/html/

🌐 Final URL
Visit the site at: http://<VM_PUBLIC_IP>

📸 Screenshots
![Screenshot (200)](https://github.com/user-attachments/assets/ef68c1b8-897c-4cc5-a74f-07e0fe9053a8)
![Screenshot (201)](https://github.com/user-attachments/assets/c6df656e-42b4-4f54-a331-2702bf6e4b04)


