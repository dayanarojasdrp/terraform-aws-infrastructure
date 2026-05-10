
# Architecture and Design Decisions

## Introduction

This document explains the main technical and architectural decisions made during the development of the Terraform AWS Infrastructure project.

The objective of the project was not only to deploy infrastructure in AWS, but also to demonstrate an understanding of cloud networking, Infrastructure as Code principles, modular Terraform design, security practices, and reproducible cloud environments.

All decisions were made with the intention of balancing simplicity, realism, security, cost control, and maintainability within a Free Tier-friendly environment.

---

# AWS Region Selection

## Selected Region

```txt
us-east-1
````

The `us-east-1` region was selected because it is one of the most commonly used AWS regions and provides broad Free Tier compatibility for EC2 and networking services.

Additional reasons for choosing this region:

* Stable Terraform provider support
* High AWS service availability
* Large amount of public documentation and community examples
* Lower probability of service limitations during testing
* Compatibility with Free Tier resources

Using a single region also simplified infrastructure management and reduced unnecessary complexity during the first implementation phase.

---

# VPC CIDR Design

## Selected VPC CIDR

```txt
10.0.0.0/16
```

The `/16` CIDR block was selected because it provides a large private address space while remaining easy to organize and expand.

This design allows future growth without requiring VPC redesign or CIDR reallocation.

The VPC was intentionally isolated from default AWS networking resources to simulate a cleaner and more production-oriented architecture.

---

# Subnet Separation

## Public Subnet

```txt
10.0.1.0/24
```

## Private Subnet

```txt
10.0.2.0/24
```

The infrastructure was intentionally divided into public and private subnets to demonstrate network segmentation and security boundaries.

The public subnet was created for resources that require internet access, specifically the bastion host.

The private subnet was created for internal workloads that should not be directly exposed to the public internet.

This separation reflects a common enterprise cloud architecture pattern and improves security by reducing unnecessary public exposure.

---

# Bastion Host Design

A bastion host was implemented as the single controlled entry point into the private network.

Instead of exposing the private application server directly to the internet, administrative access is routed through the bastion EC2 instance.

This decision was made to demonstrate:

* Secure SSH architecture
* Controlled administrative access
* Public-to-private network segmentation
* Layered security concepts

The bastion host represents a simplified but realistic implementation of secure infrastructure access management.

---

# Private Application Server Isolation

The private application EC2 instance was intentionally deployed without a public IP address.

This decision ensures that the server cannot be accessed directly from the internet.

SSH access is only permitted from the bastion security group, creating a trust relationship between the two instances.

This design demonstrates:

* Internal workload isolation
* Controlled east-west traffic
* Security Group dependency architecture
* Reduced attack surface

---

# Security Group Strategy

Security Groups were configured with minimal required access rules following the principle of least privilege.

## Bastion Security Group

Allows:

* SSH access (TCP 22) from the administrator IP
* Outbound internet access

## Private Application Security Group

Allows:

* SSH access only from the bastion security group
* Outbound traffic

This approach prevents unrestricted direct access to internal resources while maintaining operational simplicity for testing purposes.

---

# IAM Role Integration

An IAM Role and IAM Instance Profile were attached to the EC2 instances.

The decision to use IAM Roles instead of hardcoded AWS credentials was made to follow AWS security best practices.

This architecture demonstrates:

* Temporary credential usage
* Identity-based access management
* Secure EC2 authentication
* Elimination of embedded access keys

At the current stage of the project, the IAM Role acts as a foundational security component and can later be expanded with additional permissions if needed.

---

# Terraform Modular Structure

The infrastructure was divided into independent Terraform modules:

* networking
* security
* compute
* iam

This decision was made to improve:

* Readability
* Maintainability
* Reusability
* Logical separation of responsibilities

Using modules also makes the infrastructure easier to scale into future environments such as staging or production.

The `environments/dev` layer acts as the orchestration layer that combines all modules into a complete infrastructure deployment.

---

# Remote Terraform State

Terraform state was configured to use a remote S3 backend.

This decision was made because local Terraform state files can easily become inconsistent, difficult to manage, or unsafe in collaborative environments.

The remote backend provides:

* Centralized state management
* State persistence
* Improved reproducibility
* Safer Terraform workflows
* Better preparation for team-based environments

State locking support was also enabled to reduce the risk of concurrent state modifications.

---

# Cost Optimization Decisions

Several design decisions were intentionally made to minimize AWS costs during development and testing.

These include:

* Use of Free Tier-compatible EC2 instances (`t2.micro`)
* Single Availability Zone deployment
* No NAT Gateway deployment
* Minimal number of EC2 instances
* Controlled infrastructure lifecycle using Terraform destroy
* Avoidance of unnecessary managed services

The project was designed to remain lightweight while still demonstrating core cloud engineering concepts.

---

# Infrastructure Lifecycle Strategy

The infrastructure was intentionally designed to be fully reproducible through Terraform.

The project supports:

```txt
terraform init
terraform plan
terraform apply
terraform destroy
```

This workflow demonstrates Infrastructure as Code principles and ensures the environment can be recreated consistently from source-controlled Terraform files.

Destroy capability was considered an important part of the architecture to demonstrate resource lifecycle management and cost control practices.

---

# Documentation Strategy

Documentation was treated as part of the engineering process rather than an optional addition.

Separate documentation files were created for:

* Architecture
* Networking
* Security
* Limitations
* Troubleshooting
* Evidence collection

This decision was made to demonstrate operational clarity, maintainability, and professional infrastructure communication practices.

---

# Final Decision Summary

The overall architecture was intentionally designed to balance:

* Simplicity
* Security
* Reproducibility
* Real-world cloud practices
* Cost awareness
* Terraform modularity

Although the environment is relatively small, the project demonstrates foundational cloud engineering concepts that are commonly used in larger production infrastructures.


