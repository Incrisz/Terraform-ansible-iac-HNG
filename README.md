# Infrastructure as Code (IaC) with Terraform and Ansible

## Overview
This repository contains the Infrastructure as Code (IaC) setup using Terraform and Ansible to provision and configure cloud servers, deploy an application, and manage security configurations. The setup enables fully automated deployment using a single command.

## Features
- **Automated Infrastructure Provisioning**: Deploys cloud servers dynamically.
- **Security Configuration**: Configures security groups for safe access.
- **Ansible Integration**: Automatically generates an Ansible inventory and triggers playbook execution.
- **Application Deployment**: Deploys the application using Docker and Docker Compose.
- **SSL/TLS with Traefik**: Ensures secure access to the application.
- **Single Command Deployment**: Run `terraform apply -auto-approve` to execute the entire setup.

---

## Prerequisites
Ensure you have the following installed:

### **1. System Requirements**
- **Operating System**: Linux/macOS (Windows users should use WSL2 or a virtual machine)
- **CPU & Memory**: At least 2 vCPUs and 4GB RAM recommended

### **2. Required Software**
- **Terraform** (v1.5+): [Download & Install](https://developer.hashicorp.com/terraform/downloads)
- **Ansible** (v2.10+): [Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/)
- **Docker & Docker Compose**: [Installation Guide](https://docs.docker.com/get-docker/)
- **Git**: [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

---

## Setup & Usage

### **Step 1: Clone the Repository**
```sh
 git clone https://github.com/yourusername/infra-automation.git
 cd infra-automation
```

### **Step 2: Configure Environment Variables**
Create a `.env` file and set necessary variables:
```sh
cp .env.example .env
nano .env
```
Modify the `.env` file with your cloud provider credentials and application-specific settings.

### **Step 3: Initialize Terraform**
Navigate to the Terraform directory and initialize Terraform:
```sh
cd terraform
terraform init
```

### **Step 4: Deploy the Infrastructure**
Run the following command to provision infrastructure and deploy the application:
```sh
terraform apply -auto-approve
```
This will:
1. Provision the cloud server.
2. Configure security groups.
3. Generate an Ansible inventory file dynamically.
4. Trigger Ansible to install dependencies, clone the app, and deploy it using Docker Compose.

### **Step 5: Verify Deployment**
Once the process completes, retrieve the server IP using:
```sh
echo "Application deployed at: http://$(terraform output -raw public_ip)"
```

---

## Repository Structure
```
infra-automation/
├── terraform/                # Terraform scripts
│   ├── main.tf               # Main Terraform configuration
│   ├── variables.tf          # Variables used in Terraform
│   ├── outputs.tf            # Outputs such as public IP
│   ├── ansible_inventory.tpl # Template for Ansible inventory
│   ├── user_data.sh          # Cloud-init script (if applicable)
│   ├── README.md             # Terraform-specific documentation
│
├── ansible/                  # Ansible playbooks and roles
│   ├── roles/
│   │   ├── dependencies/      # Installs Docker & dependencies
│   │   ├── deployment/        # Deploys the application
│   ├── inventory.ini          # Ansible inventory file
│   ├── playbook.yml           # Main Ansible playbook
│
├── .env.example               # Example environment file
├── README.md                  # Project documentation
```

---

## Infrastructure Details
- **Cloud Provider**: (AWS)
- **Server Type**: (EC2)
- **Security Rules**: SSH (22), HTTP (80), HTTPS (443), 8080
- **Configuration Management**: Ansible automates package installation & deployment
- **Deployment**:
  - Pulls the application code from a Git repository
  - Deploys it inside a Docker container using Docker Compose
  - Uses Traefik for SSL/TLS management

---

## Troubleshooting
If deployment fails, check:
- Terraform logs (`terraform plan` for issues before applying changes)
- Ansible logs (`ansible-playbook -i inventory.ini playbook.yml --check`)
- SSH into the server (`ssh -i your_key.pem user@public_ip`)
- Docker container logs (`docker ps && docker logs <container_id>`)

---

## Cleanup & Teardown
To destroy all provisioned infrastructure, run:
```sh
terraform destroy -auto-approve
```
This will remove the cloud servers and free up resources.

---

## Future Improvements
- Add monitoring with Prometheus & Grafana
- Enable rolling updates with zero downtime
- Improve security with IAM policies

---

## Contributing
Contributions are welcome! Please fork the repo, create a branch, and submit a PR.

---

## License
This project is licensed under the MIT License.

---

## Contact
For support, contact [Godwinincrisz@gmail.com] or open an issue in this repository.

