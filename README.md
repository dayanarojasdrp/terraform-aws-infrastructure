# Terraform AWS Infrastructure

Production-style AWS infrastructure project built with **Terraform** using a modular architecture, remote state management, VPC networking, IAM roles, security groups, EC2 instances, and secure private connectivity through a bastion host.

This project demonstrates practical **Infrastructure as Code (IaC)** skills using Terraform and AWS. The goal is to provision a secure and organized cloud environment similar to the foundations used in real DevOps and cloud engineering workflows.

---

## What This Project Demonstrates

This project demonstrates practical experience with:

- Terraform Infrastructure as Code
- Modular Terraform architecture
- AWS VPC networking
- Public and private subnet design
- Internet Gateway and route tables
- EC2 provisioning
- Bastion host access pattern
- Private EC2 instance isolation
- IAM role and instance profile configuration
- Security group design
- Remote Terraform state with Amazon S3
- Environment-based infrastructure organization
- Terraform plan, apply, output, state, and destroy workflows
- Infrastructure validation and evidence capture

---

## Architecture

```text
Internet
   |
   v
Public Subnet
   |
   v
Bastion Host EC2
   |
   v
Private Subnet
   |
   v
Private Application EC2
```

The bastion host provides controlled SSH access to the private EC2 instance without exposing the private instance directly to the internet.

---

## What This Builds

The Terraform configuration provisions:

- Custom VPC
- Public subnet
- Private subnet
- Internet Gateway
- Public route table
- Private route table
- Route table associations
- Security groups
- Bastion EC2 instance
- Private EC2 application instance
- IAM role
- IAM instance profile
- S3 remote backend for Terraform state

---

## Tech Stack

| Area | Tools / Services |
|---|---|
| Infrastructure as Code | Terraform |
| Cloud Provider | AWS |
| Compute | EC2 |
| Networking | VPC, Subnets, Route Tables, Internet Gateway |
| Access Pattern | Bastion Host |
| Identity and Access | IAM Role, IAM Instance Profile |
| Security | Security Groups |
| Remote State | Amazon S3 |
| OS | Amazon Linux 2023 |
| Version Control | Git, GitHub |

---

## Repository Structure

```text
terraform-aws-infrastructure/
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

## Terraform Modules

| Module | Purpose |
|---|---|
| `networking` | Creates VPC, public/private subnets, route tables, and Internet Gateway |
| `security` | Defines security groups for bastion and private EC2 access |
| `compute` | Provisions bastion and private EC2 instances |
| `iam` | Creates IAM role and instance profile |

---

## Security Design

This project follows a basic secure network architecture:

| Component | Security Purpose |
|---|---|
| Public subnet | Hosts the bastion instance |
| Private subnet | Hosts the private application instance |
| Bastion host | Provides controlled SSH access to private resources |
| Private EC2 | Not directly exposed to the internet |
| Security groups | Restrict inbound and outbound traffic |
| IAM role | Provides controlled AWS permissions |
| S3 backend | Stores Terraform state remotely |

---

## Remote State Management

Terraform state is stored remotely in Amazon S3.

Remote state helps with:

- Centralized state management
- Safer infrastructure workflows
- Better collaboration
- Reduced risk of local state loss
- More consistent infrastructure operations

---

## Deployment Workflow

Go to the development environment:

```bash
cd environments/dev
```

Initialize Terraform:

```bash
terraform init
```

Validate configuration:

```bash
terraform validate
```

Review the execution plan:

```bash
terraform plan
```

Apply the infrastructure:

```bash
terraform apply
```

View outputs:

```bash
terraform output
```

Destroy infrastructure when finished:

```bash
terraform destroy
```

---

## SSH Verification

The infrastructure was tested by:

1. Connecting to the bastion host using its public IP.
2. Using the bastion host to connect to the private EC2 instance.
3. Verifying that the private instance is not directly exposed to the internet.
4. Confirming that the security groups and network routing support the intended access pattern.

This validates:

- Public subnet access
- Private subnet isolation
- Bastion host connectivity
- Security group behavior
- EC2 provisioning
- VPC routing

---

## Infrastructure Evidence

This repository includes deployment and validation evidence under:

```text
docs/evidence/
```

Evidence includes Terraform command output, AWS resource screenshots, and infrastructure validation files.

### AWS Resource Evidence

| Evidence | File |
|---|---|
| EC2 instances | [EC2.png](docs/evidence/EC2.png) |
| VPC | [VPC.png](docs/evidence/VPC.png) |
| Subnet | [Subnet.png](docs/evidence/Subnet.png) |
| Route tables | [Routetables.png](docs/evidence/Routetables.png) |
| Security groups | [securitygroups.png](docs/evidence/securitygroups.png) |
| IAM role | [Role.png](docs/evidence/Role.png) |
| S3 backend | [S3.png](docs/evidence/S3.png) |

### Terraform Evidence

| Evidence | File |
|---|---|
| Terraform init | [terraform-init.txt](docs/evidence/terraform-init.txt) |
| Terraform validate | [terraform-validate.txt](docs/evidence/terraform-validate.txt) |
| Terraform plan | [terraform-plan.txt](docs/evidence/terraform-plan.txt) |
| Terraform plan phase 1 | [terraform-plan-complete-phase1.txt](docs/evidence/terraform-plan-complete-phase1.txt) |
| Terraform security plan | [terraform-plan-security.txt](docs/evidence/terraform-plan-security.txt) |
| Terraform apply | [terraform-apply.txt](docs/evidence/terraform-apply.txt) |
| Terraform output | [terraform-output.txt](docs/evidence/terraform-output.txt) |
| Terraform current state | [terraform-current-state.txt](docs/evidence/terraform-current-state.txt) |
| AWS resources summary | [aws-resources.txt](docs/evidence/aws-resources.txt) |
| Terraform destroy | [terraform-destroy.txt](docs/evidence/terraform-destroy.txt) |

This evidence shows that the infrastructure was not only written, but also planned, applied, validated, inspected, and destroyed.

---

## Key DevOps Concepts Demonstrated

This project demonstrates:

- Infrastructure as Code
- Modular Terraform design
- AWS networking fundamentals
- Secure cloud access patterns
- Bastion host architecture
- Private subnet isolation
- IAM role usage
- Security group configuration
- Remote state management
- Infrastructure lifecycle management
- Evidence-based validation

---

## Current Limitations

This project is an infrastructure portfolio project, not a full production platform.

Current limitations:

- Single development environment only
- No NAT Gateway
- No load balancer
- No auto scaling group
- No application deployment pipeline
- No CI/CD workflow for Terraform yet
- No DynamoDB state locking yet
- No CloudWatch logging configuration
- No advanced policy scanning tools yet

These limitations are intentional to keep the project focused on Terraform fundamentals, AWS networking, secure access, and remote state management.

---

## Future Improvements

Potential improvements:

- Add DynamoDB state locking
- Add Terraform CI validation with GitHub Actions
- Add NAT Gateway for controlled private subnet egress
- Add Application Load Balancer
- Add Auto Scaling Group
- Add CloudWatch logging and metrics
- Add Checkov or tfsec scanning
- Add multiple environments such as `dev`, `staging`, and `prod`
- Add EC2 user data automation
- Add documentation for cost considerations

---

## Lessons Learned

During this project, I practiced:

- Building AWS infrastructure from scratch
- Organizing Terraform code into reusable modules
- Managing Terraform state remotely
- Working with public and private subnets
- Configuring route tables and Internet Gateway access
- Creating EC2 instances with controlled network exposure
- Using a bastion host to access private infrastructure
- Debugging SSH and AWS networking issues
- Capturing evidence for infrastructure validation

---

## Why This Project Matters

This project shows how cloud infrastructure can be created, organized, secured, and managed using Terraform.

It follows a practical infrastructure workflow:

```text
Terraform configuration
        ↓
Modular infrastructure design
        ↓
Terraform init / validate / plan
        ↓
AWS infrastructure deployment
        ↓
Remote state management
        ↓
SSH and networking validation
        ↓
Evidence capture
        ↓
Infrastructure cleanup
```

The project demonstrates the foundation of real DevOps and cloud engineering work: building infrastructure that is reproducible, documented, and reviewable.

---

## Final Notes

This repository is part of my DevOps, Cloud, and Infrastructure as Code portfolio.

It demonstrates my ability to use Terraform and AWS to provision a secure, modular, and validated cloud infrastructure environment with public/private networking, EC2 access patterns, IAM roles, security groups, and remote state management.
