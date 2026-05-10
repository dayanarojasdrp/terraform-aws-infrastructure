
# Security Design and Access Control

## Introduction

This document explains the security decisions and access control mechanisms implemented in the Terraform AWS Infrastructure project.

The objective of the security layer was to create a simple but realistic cloud security architecture while maintaining compatibility with AWS Free Tier resources and Terraform reproducibility principles.

The infrastructure was intentionally designed to demonstrate foundational security concepts commonly used in AWS environments, including:

- Public and private network separation
- Restricted SSH access
- Bastion host architecture
- Security Group isolation
- IAM Role integration
- Secure credential handling
- Infrastructure as Code security practices

Although the environment is intentionally lightweight, the project follows security-oriented design principles rather than exposing all resources directly to the internet.

---

# Security Architecture Overview

The infrastructure follows a layered access model:

```txt id="t0dfjk"
Internet
↓
Public Subnet
↓
Bastion Host
↓
Private Subnet
↓
Private Application EC2
````

This architecture reduces direct exposure of internal resources and creates a controlled administrative access path into the environment.

The private EC2 instance is intentionally isolated from direct public access.

---

# Public and Private Isolation

One of the core security decisions in the project was separating resources into:

* Public subnet
* Private subnet

The public subnet hosts only the bastion instance.

The private subnet hosts the internal application EC2 instance.

This separation helps reduce the attack surface by ensuring that internal workloads are not directly reachable from the public internet.

---

# Security Groups

AWS Security Groups act as virtual firewalls controlling inbound and outbound traffic for EC2 instances.

Two dedicated Security Groups were implemented:

* Bastion Security Group
* Private Application Security Group

---

# Bastion Security Group

## Purpose

The bastion security group controls access to the public bastion host.

The bastion instance acts as the single administrative entry point into the infrastructure.

## Inbound Rules

Allowed:

```txt id="d50e7j"
TCP 22 (SSH)
```

Source:

```txt id="trhj3l"
Administrator public IP
```

This allows secure SSH access from the administrator machine into the bastion host.

## Outbound Rules

Allowed:

```txt id="3nh92y"
All outbound traffic
```

This simplifies connectivity testing and allows the bastion host to communicate with internal resources.

---

# Private Application Security Group

## Purpose

The private application security group protects the internal EC2 application server located inside the private subnet.

This instance does not receive a public IP address.

## Inbound Rules

Allowed:

```txt id="6t2ww7"
TCP 22 (SSH)
```

Source:

```txt id="i7j8g0"
Bastion Security Group
```

This is one of the most important security relationships in the architecture.

Instead of allowing direct SSH access from the internet, the private EC2 instance only accepts traffic originating from the bastion host security group.

This creates a controlled trust boundary between the public and private network layers.

## Outbound Rules

Allowed:

```txt id="r2fjph"
All outbound traffic
```

Outbound access was intentionally left open for simplicity during the first implementation phase.

Future improvements could include more restrictive outbound traffic policies.

---

# Bastion Host Security Model

The bastion host was implemented as a simplified jump server architecture.

Purpose of the bastion host:

* Centralize administrative access
* Avoid direct exposure of private resources
* Create layered SSH access
* Simulate enterprise-style infrastructure access patterns

This model is commonly used in cloud environments where internal servers should not be directly reachable from the public internet.

The bastion host is the only EC2 instance with a public IP address.

---

# Private EC2 Isolation

The private EC2 instance was intentionally configured without a public IP address.

This decision prevents:

* Direct internet SSH access
* Public inbound exposure
* Unrestricted external connectivity

Access to the private instance is only possible by first connecting to the bastion host.

This demonstrates a basic but important cloud isolation pattern.

---

# IAM Security Integration

The project includes:

* IAM Role
* IAM Instance Profile

attached to the EC2 instances.

The purpose of this integration is to demonstrate secure AWS authentication practices.

Instead of storing AWS credentials directly inside EC2 instances, the environment uses IAM-based identity attachment.

Current IAM implementation includes:

* EC2 IAM Role
* EC2 Instance Profile
* AssumeRole policy for EC2 service

The IAM Role currently provides foundational identity architecture and can be expanded in future versions with additional AWS permissions if needed.

---

# Credential Security Practices

Several important credential-handling practices were implemented during development.

## Terraform Variables

Sensitive values such as:

* SSH key names
* Infrastructure configuration values

were stored inside:

```txt id="2e1b6t"
terraform.tfvars
```

This file was excluded from Git tracking using `.gitignore`.

---

# SSH Private Keys

SSH private keys (`.pem`) were intentionally excluded from the repository.

After an accidental exposure during development, the compromised key was:

* Removed locally
* Deleted from AWS
* Replaced with a new key pair
* Moved outside the repository structure

This process reinforced secure credential management practices during Infrastructure as Code workflows.

---

# Remote State Security

Terraform remote state was configured using Amazon S3.

The backend includes:

* Encryption enabled
* Centralized state storage
* State locking support
* Controlled backend configuration

Remote state improves consistency and reduces the risk of infrastructure drift or local state corruption.

---

# Infrastructure as Code Security

The infrastructure was designed to be fully reproducible through Terraform.

Benefits of this approach include:

* Version-controlled infrastructure
* Repeatable deployments
* Easier auditing
* Reduced manual configuration errors
* Consistent security configurations

All infrastructure changes are visible through:

```txt id="8l3u14"
terraform plan
```

before deployment.

This improves infrastructure transparency and reduces accidental configuration drift.

---

# Security Limitations

The current environment intentionally keeps security relatively lightweight in order to remain:

* Educational
* Readable
* Free Tier-friendly
* Easy to troubleshoot

The following advanced security features were intentionally excluded from the initial version:

* MFA enforcement
* AWS WAF
* IDS/IPS systems
* Session Manager
* VPC Flow Logs
* Security Hub
* CloudTrail auditing
* Advanced IAM least-privilege policies
* Private CA infrastructure

These could be implemented in future iterations if the project evolves into a more advanced production-style environment.

---

# Security Philosophy

The overall security philosophy of the project was based on:

* Least privilege concepts
* Reduced public exposure
* Controlled administrative access
* Identity-based AWS authentication
* Infrastructure reproducibility
* Simplicity over unnecessary complexity

The environment intentionally demonstrates realistic foundational cloud security concepts without introducing excessive operational overhead.

---

# Final Security Summary

The project successfully demonstrates several important AWS security principles, including:

* Public and private subnet isolation
* Bastion host architecture
* Security Group trust relationships
* Restricted SSH access
* IAM Role integration
* Secure credential handling
* Infrastructure as Code security workflows

Although simplified, the environment reflects realistic cloud security patterns commonly used in AWS infrastructure deployments.

