
# Networking Design and Architecture

## Introduction

This document explains the networking architecture implemented in the Terraform AWS Infrastructure project.

The networking layer was designed to simulate a simplified but realistic cloud environment using AWS networking services and Terraform Infrastructure as Code principles.

The main objectives of the networking design were:

- Create isolated cloud infrastructure
- Separate public and private workloads
- Control traffic flow explicitly
- Demonstrate routing concepts
- Implement secure network segmentation
- Maintain a Free Tier-friendly architecture

The infrastructure follows a layered networking model commonly used in real AWS environments.

---

# AWS Region

## Selected Region

```txt
us-east-1
````

The infrastructure was deployed in the `us-east-1` AWS region.

This region was selected because of:

* Stable Free Tier support
* Broad AWS service availability
* Lower probability of Terraform provider issues
* Large ecosystem of AWS documentation and examples
* Simpler troubleshooting during development

The entire networking architecture was intentionally kept inside a single region to reduce operational complexity during the first implementation phase.

---

# Virtual Private Cloud (VPC)

## VPC CIDR Block

```txt id="46fv4i"
10.0.0.0/16
```

The VPC acts as the isolated network boundary for all infrastructure resources in the project.

The `/16` network range was selected to provide enough address space for future subnet expansion while maintaining a clean and simple IP structure.

The VPC was configured with:

* DNS support enabled
* DNS hostnames enabled

These settings allow EC2 instances to resolve internal AWS DNS names and support future service integrations.

---

# Public and Private Network Segmentation

One of the most important networking decisions in this project was the separation between public and private resources.

The infrastructure uses two independent subnets:

* Public subnet
* Private subnet

This separation demonstrates a foundational cloud security pattern commonly used in AWS production environments.

---

# Public Subnet

## CIDR Block

```txt id="dkkwsi"
10.0.1.0/24
```

The public subnet hosts the bastion EC2 instance.

This subnet was configured with:

```txt id="5j8nyr"
map_public_ip_on_launch = true
```

This means instances launched inside the subnet automatically receive public IP addresses.

The public subnet is associated with a route table that sends internet traffic to the Internet Gateway.

Purpose of the public subnet:

* SSH administration
* Controlled internet access
* Bastion host connectivity
* Public entry point into the infrastructure

---

# Private Subnet

## CIDR Block

```txt id="nifjlwm"
10.0.2.0/24
```

The private subnet hosts the internal application EC2 instance.

Unlike the public subnet, this subnet does not assign public IP addresses to instances.

The private subnet was intentionally isolated from direct internet access.

Purpose of the private subnet:

* Internal workloads
* Reduced public exposure
* Network isolation
* Demonstration of layered cloud security

The private instance can only be accessed through the bastion host.

---

# Internet Gateway

An Internet Gateway (IGW) was attached to the VPC to provide internet connectivity for public resources.

The Internet Gateway acts as the bridge between the AWS VPC and the public internet.

Only the public subnet route table contains a default route to the Internet Gateway.

This ensures that internet access is restricted only to approved public resources.

---

# Route Tables

Two independent route tables were created:

* Public route table
* Private route table

This separation allows different traffic behavior depending on the subnet role.

---

# Public Route Table

The public route table contains the following route:

```txt id="90j63k"
0.0.0.0/0 → Internet Gateway
```

This route allows outbound and inbound internet communication for instances located in the public subnet.

The public route table is associated only with the public subnet.

---

# Private Route Table

The private route table contains only local VPC routing.

This means:

* Private instances can communicate internally inside the VPC
* Private instances cannot receive direct inbound internet traffic
* Internet exposure is minimized

A NAT Gateway was intentionally not implemented in order to reduce AWS costs and remain within Free Tier-friendly architecture boundaries.

---

# Bastion Access Flow

The bastion host was implemented as the controlled access bridge between the internet and the private subnet.

The traffic flow works as follows:

```txt id="q9c3k2"
Administrator
↓
Public Internet
↓
Internet Gateway
↓
Public Subnet
↓
Bastion EC2
↓
Private Subnet
↓
Private EC2
```

This architecture prevents direct public exposure of internal resources while still allowing administrative access for testing and management purposes.

---

# Security Group Relationship

Networking and security were intentionally designed together.

The networking architecture works closely with Security Groups to enforce traffic restrictions.

## Bastion Security Group

Allows:

* SSH access from the administrator IP
* Outbound traffic

## Private Application Security Group

Allows:

* SSH access only from the bastion security group
* Outbound traffic

This creates a controlled trust relationship between the public and private layers.

---

# Availability Zone Strategy

The infrastructure currently uses a single Availability Zone:

```txt id="v6n8lq"
us-east-1a
```

This decision was made intentionally to:

* Simplify the architecture
* Reduce Free Tier resource usage
* Minimize operational complexity
* Focus on core networking concepts first

Future versions of the project could expand into multi-AZ architectures for higher availability and fault tolerance.

---

# Terraform Networking Modularity

All networking resources were isolated inside a dedicated Terraform module:

```txt id="o12r3f"
modules/networking
```

This module contains:

* VPC
* Subnets
* Internet Gateway
* Route tables
* Route associations

The modular design improves:

* Reusability
* Maintainability
* Readability
* Environment scalability

The networking module exports outputs consumed by other modules such as:

* security
* compute

This demonstrates Terraform dependency flow between infrastructure layers.

---

# Networking Security Philosophy

The networking design follows several important cloud security principles:

* Minimize direct internet exposure
* Separate public and private workloads
* Restrict administrative access paths
* Isolate internal infrastructure
* Explicitly define traffic routes
* Avoid unnecessary open networking paths

Although simplified for educational purposes, the architecture reflects realistic cloud networking patterns commonly used in enterprise AWS environments.

---

# Final Networking Summary

The networking architecture implemented in this project demonstrates foundational AWS cloud networking concepts using Terraform.

The environment successfully implements:

* VPC isolation
* Public and private subnet segmentation
* Internet routing
* Controlled administrative access
* Layered network security
* Terraform modular networking
* Infrastructure reproducibility

The final result is a lightweight but realistic AWS networking environment designed to support future expansion while maintaining simplicity, readability, and cost awareness.

