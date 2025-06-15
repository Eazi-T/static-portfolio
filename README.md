# Static Website Deployment with Azure VM and GitHub Actions

This project demonstrates how to deploy a static portfolio website to a Virtual Machine (VM) on Microsoft Azure using NGINX and GitHub Actions.

## 🚀 Project Structure

Capstone Project/
├── DevFolio/
│ ├── index.html
│ ├── css/
│ ├── js/
│ └── assets/
├── deploy.sh
└── README.md


## ⚙️ Technologies Used

- **Azure VM (Ubuntu 22.04)**
- **NGINX Web Server**
- **GitHub Actions** for CI/CD
- **Bash scripting** for provisioning

# 🚀 Automated Deployment with GitHub Actions

This project is now automatically deployed to an Azure VM whenever you push to the `main` branch.

### 🔧 How it works

- The GitHub Actions workflow:
  - Connects to your Azure VM via SSH
  - Uploads files from the `DevFolio/` directory
  - Updates `/var/www/html/` on the server
  - Restarts the NGINX web server

🌐 Final URL
Visit the site at: http://<VM_PUBLIC_IP>