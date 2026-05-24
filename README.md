# azure-docker-terraform-project

Overview

This project demonstrates deploying a containerized application on Microsoft Azure using Docker and Terraform.

It includes networking, security, and container registry integration aligned with real-world cloud architecture and AZ-700 concepts.

🏗️ Architecture
Azure Container Instance (ACI) for running Docker container
Azure Container Registry (ACR) for storing Docker images
Virtual Network (VNet) with frontend and backend subnets
Network Security Group (NSG) for traffic control
Azure Storage Account for backend services
🧰 Technologies Used
Terraform
Docker
Microsoft Azure
Azure CLI
Python (Flask)


📁 Project Structure
azure-docker-terraform-project/



├── app/
│   ├── app.py
│   └── Dockerfile



├── infra/
│   ├── main.tf
│   ├── provider.tf
│
└── README.md


🐳 Docker Setup
Build Image
docker build -t myapp:v1 .


Tag Image
docker tag myapp:v1 <acr-name>.azurecr.io/myapp:v1


Push Image
docker push <acr-name>.azurecr.io/myapp:v1


☁️ Azure Setup
Login
az login
Create ACR
az acr create --name <acr-name> --resource-group <rg> --sku Basic
⚙️ Terraform Deployment
Initialize
terraform init
Plan
terraform plan
Apply
terraform apply
🌐 Output

After deployment, access the application:


http://<dns-name>.centralindia.azurecontainer.io
🔐 Security Features
NSG rules to allow only HTTP traffic
Private container registry (ACR)
Network isolation using VNet



🎯 Key Learnings
Infrastructure as Code using Terraform
Container deployment on Azure
Azure networking (AZ-700 concepts)
Secure image management with ACR
🚀 Future Enhancements
Use Azure Kubernetes Service (AKS)
Add Application Gateway


<img width="1259" height="480" alt="image" src="https://github.com/user-attachments/assets/c2daaf20-c2c0-441b-bb61-4ff0d63a7ed1" />

Implement CI/CD using GitHub Actions
Use Managed Identity instead of admin credentials
