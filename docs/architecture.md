
# Architecture Overview

## Project Purpose

This project was designed to demonstrate the implementation of a real AWS cloud infrastructure using Terraform following Infrastructure as Code (IaC) principles. The environment was intentionally structured to simulate a small but realistic production-oriented architecture with public and private network separation, controlled access, modular Terraform design, remote state management, and basic IAM integration.

The main goal of the project is not simply to deploy EC2 instances, but to demonstrate understanding of cloud networking, infrastructure automation, security boundaries, and reproducible Terraform workflows.

---

# High-Level Architecture

The infrastructure is deployed inside a dedicated AWS Virtual Private Cloud (VPC) in the `us-east-1` region. The architecture separates resources into public and private network layers to follow common cloud security practices.

The environment contains:

- One VPC
- One public subnet
- One private subnet
- One Internet Gateway
- Public and private route tables
- Security Groups with restricted access rules
- One bastion EC2 instance in the public subnet
- One private EC2 application instance
- IAM Role and Instance Profile for EC2 authentication
- Remote Terraform state stored in Amazon S3

---

# Network Design

## VPC

The VPC acts as the isolated network boundary for all resources deployed in the project.

CIDR Block:

```txt
10.0.0.0/16
````

The `/16` range was selected to provide enough address space for future subnet expansion while maintaining a simple and readable network structure.

The VPC has DNS support and DNS hostnames enabled in order to allow internal name resolution between instances and AWS-managed services.

---

# Public Subnet

CIDR Block:

```txt
10.0.1.0/24
```

The public subnet contains the bastion host. This subnet is associated with a public route table connected to the Internet Gateway, allowing inbound and outbound internet connectivity.

Resources inside this subnet automatically receive public IP addresses.

Purpose of the public subnet:

* SSH access from the internet
* Administrative access
* Bastion host deployment
* Controlled entry point into the private network

---

# Private Subnet

CIDR Block:

```txt
10.0.2.0/24
```

The private subnet contains the internal application EC2 instance. This subnet is intentionally isolated from direct internet access.

The private instance does not receive a public IP address and can only be accessed internally through the bastion host using SSH.

Purpose of the private subnet:

* Internal application workloads
* Isolation from public internet exposure
* Demonstration of layered cloud security architecture

---

# Internet Gateway

An Internet Gateway (IGW) is attached to the VPC to provide internet connectivity for resources located in the public subnet.

The public route table contains the following route:

```txt
0.0.0.0/0 → Internet Gateway
```

This enables outbound and inbound internet traffic only for resources associated with the public subnet.

The private subnet does not use the Internet Gateway directly.

---

# Route Tables

Two route tables were created to separate traffic behavior between public and private networks.

## Public Route Table

Associated with the public subnet.

Contains:

```txt
0.0.0.0/0 → Internet Gateway
```

This allows the bastion host to communicate with the internet.

## Private Route Table

Associated with the private subnet.

Contains only local VPC routing.

This ensures the private application instance remains inaccessible directly from the public internet.

---

# Security Architecture

## Bastion Security Group

The bastion security group allows:

* SSH access (TCP 22) from the administrator IP
* All outbound traffic

The bastion host acts as the only approved entry point into the private network.

## Private Application Security Group

The private application security group allows:

* SSH access only from the bastion security group
* All outbound traffic

This creates a controlled trust relationship between the bastion instance and the private application server.

The private EC2 instance cannot be reached directly from the internet.

---

# EC2 Compute Layer

## Bastion Host

The bastion host is deployed in the public subnet and receives a public IP address.

Purpose:

* Administrative SSH access
* Connectivity testing
* Secure access bridge into the private subnet

This instance represents a common enterprise pattern used to avoid exposing internal systems directly to the internet.

---

## Private Application Instance

The private application EC2 instance is deployed inside the private subnet and does not receive a public IP address.

Purpose:

* Simulated internal application server
* Demonstration of private network isolation
* Validation of routing and security group rules

Access to this instance is only possible through the bastion host.

---

# IAM Integration

An IAM Role and IAM Instance Profile were created and attached to both EC2 instances.

The purpose of this configuration is to demonstrate secure AWS authentication practices without hardcoding credentials inside the servers.

The IAM Role currently provides the foundation for future permissions expansion while maintaining the principle of least privilege.

This architecture demonstrates the standard AWS relationship:

```txt
IAM Role
↓
Instance Profile
↓
EC2 Instance
```

---

# Terraform Remote State

Terraform state is stored remotely in Amazon S3.

Purpose of remote state:

* Prevent local state inconsistencies
* Improve reproducibility
* Simulate collaborative Terraform workflows
* Maintain centralized infrastructure tracking

The backend configuration includes:

* S3 backend storage
* State encryption
* State locking support
* Consistent Terraform state management

---

# Modular Terraform Structure

The infrastructure was intentionally divided into reusable Terraform modules.

Modules implemented:

* networking
* security
* compute
* iam

This structure improves:

* Readability
* Maintainability
* Reusability
* Separation of responsibilities

The `environments/dev` directory acts as the orchestration layer that combines all modules together.

---

# Security Considerations

Several security-focused decisions were implemented during the design of the infrastructure:

* Public and private subnet separation
* Restricted SSH access
* Bastion-only access pattern
* No hardcoded AWS credentials inside EC2
* IAM Role usage instead of access keys
* Remote Terraform state encryption
* Sensitive files excluded from Git tracking
* Private SSH keys stored outside the repository

---

# Final Architecture Summary

This project demonstrates a foundational but realistic AWS infrastructure environment built entirely with Terraform.

The architecture reflects core cloud engineering concepts including:

* Infrastructure as Code
* Network segmentation
* Controlled access patterns
* IAM integration
* Modular Terraform design
* Remote state management
* Cloud security best practices

The final result is a reproducible cloud environment that can be fully created and destroyed through Terraform while maintaining consistency, documentation, and operational clarity.


