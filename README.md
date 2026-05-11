# Terraform AWS Infrastructure

Production-style AWS infrastructure project built with Terraform using a modular architecture, remote state management, IAM roles, networking, EC2 instances, and secure private connectivity through a bastion host.

This project was created as part of my DevOps and cloud engineering portfolio to demonstrate real-world Infrastructure as Code practices using AWS and Terraform.

---

# Project Overview

This infrastructure deploys:

- Custom VPC
- Public and private subnets
- Internet Gateway
- Route tables and subnet associations
- Security groups
- Bastion EC2 instance
- Private EC2 application instance
- IAM role and instance profile
- Remote Terraform state stored in Amazon S3

The project follows a modular Terraform structure to simulate how infrastructure is organized in real DevOps environments.

---

# Architecture

```text
Internet
   │
   ▼
Public Subnet
   │
   └── Bastion Host (EC2)
            │
            ▼
Private Subnet
   │
   └── Private Application EC2
```

The bastion host provides secure SSH access to the private instance without exposing the private EC2 directly to the internet.

---

# Technologies Used

- Terraform
- AWS EC2
- AWS VPC
- AWS IAM
- AWS S3
- Amazon Linux 2023
- SSH
- Git & GitHub

---

# Project Structure

```text
terraform-aws-infrastructure/
│
├── environments/
│   └── dev/
│       ├── backend.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       ├── terraform.tfvars
│       └── variables.tf
│
├── modules/
│   ├── compute/
│   ├── iam/
│   ├── networking/
│   └── security/
│
├── scripts/
│   ├── apply.sh
│   └── destroy.sh
│
├── docs/
│   └── evidence/
│
└── README.md
```

---

# Features Implemented

## Networking

- Custom VPC
- Public subnet
- Private subnet
- Internet Gateway
- Route tables
- Subnet associations

## Security

- Security groups
- Bastion architecture
- Private EC2 isolation
- IAM role and instance profile

## Terraform

- Modular architecture
- Reusable modules
- Variables and outputs
- Remote backend with S3
- Environment separation
- Infrastructure automation scripts

---

# Remote State Management

Terraform state is stored remotely in Amazon S3.

Benefits:
- Centralized state management
- Safer collaboration workflow
- Better infrastructure consistency
- Prevents local state corruption

---

# Deployment

Initialize Terraform:

```bash
terraform init
```

Plan infrastructure:

```bash
terraform plan -out=tfplan
```

Deploy infrastructure:

```bash
terraform apply tfplan
```

Destroy infrastructure:

```bash
terraform destroy
```

---

# SSH Verification

The project was successfully tested by:

1. Connecting to the bastion host through its public IP
2. Using the bastion host to SSH into the private EC2 instance
3. Verifying secure internal network communication

This confirms:
- VPC networking works correctly
- Security groups are properly configured
- Private subnet isolation is functioning
- Bastion architecture is operational

---

# Infrastructure Evidence

## EC2 Instances

![EC2](docs/evidence/ec2-running.png)

## VPC

![VPC](docs/evidence/vpc-created.png)

## Subnets

![Subnets](docs/evidence/subnets-created.png)

## Route Tables

![Route Tables](docs/evidence/route-tables.png)

## Security Groups

![Security Groups](docs/evidence/security-groups.png)

## IAM Role

![IAM](docs/evidence/iam-role.png)

## S3 Backend

![S3](docs/evidence/s3-backend.png)

---

# Key DevOps Concepts Demonstrated

- Infrastructure as Code (IaC)
- Cloud networking
- AWS resource provisioning
- Modular Terraform design
- Secure architecture principles
- Remote state management
- Bastion host access patterns
- Infrastructure automation
- Environment organization

---

# Lessons Learned

During this project I practiced:

- Building AWS infrastructure from scratch
- Organizing Terraform into reusable modules
- Managing Terraform state remotely
- Debugging AWS networking and SSH connectivity
- Working with security groups and private subnets
- Using Terraform in a real deployment workflow

This project helped me better understand how real cloud infrastructure is structured and managed in DevOps environments.

---

# Author

Dayana Rojas Pérez
