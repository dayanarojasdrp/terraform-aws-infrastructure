
# Project Limitations and Operational Constraints

## Introduction

This document describes the main technical, operational, and environmental limitations encountered during the development of the Terraform AWS Infrastructure project.

The purpose of this section is not to justify mistakes or incomplete work, but to transparently document the real-world conditions under which the infrastructure was designed, tested, and validated.

Understanding operational limitations is an important part of cloud engineering because infrastructure projects are often affected by networking restrictions, geographic limitations, provider policies, budget constraints, and local environment conditions.

---

# Geographic and Connectivity Constraints

One of the main challenges during this project was working under geographic and connectivity limitations associated with Cuba and restricted internet environments.

Although the project was developed from outside Cuba during part of the workflow, several operational habits and technical limitations still influenced the infrastructure process, especially regarding:

- VPN dependency
- Regional AWS access behavior
- Provider download stability
- Cloud service authentication consistency
- Access reliability to external services

Cloud engineering workflows can become more fragile when internet routing changes frequently due to VPN usage or regional restrictions.

---

# VPN Dependency and Cloud Access Stability

A VPN was required during parts of the development workflow to ensure stable access to AWS services, GitHub resources, provider downloads, and Terraform initialization processes.

This introduced several practical limitations:

- Inconsistent IP addresses during SSH configuration
- Regional routing inconsistencies
- Potential AWS session interruptions
- Delays when downloading Terraform providers
- Variability in internet latency

Because VPN endpoints can change dynamically, SSH allowlists based on IP addresses may require updates over time.

This also affected decisions related to security group design and SSH access testing.

---

# Terraform Backend Initialization Challenges

One of the first major technical issues encountered during the project involved Terraform remote backend initialization.

Initially, Terraform was configured using a placeholder S3 bucket name:

```txt id="8ifqko"
my-terraform-state-bucket
````

This resulted in multiple issues:

* Region mismatch errors
* AccessDenied responses
* Terraform backend initialization failures

The root cause was that the placeholder bucket already existed globally in another AWS account, since Amazon S3 bucket names must be globally unique.

Additional confusion was introduced by the fact that the bucket existed in a different AWS region than expected.

This issue was resolved by:

* Creating a dedicated project-specific S3 bucket
* Explicitly defining the backend region
* Reinitializing Terraform correctly
* Cleaning the `.terraform` directory before re-running initialization

This troubleshooting process became an important learning experience regarding Terraform backend architecture and AWS global naming constraints.

---

# Credential and Security Management Limitations

During development, an SSH private key was accidentally committed before `.gitignore` protections were fully configured.

Although the key was removed quickly, this incident demonstrated a realistic infrastructure security risk commonly encountered during early DevOps workflows.

The issue was mitigated by:

* Deleting the compromised key pair from AWS
* Removing the local private key
* Generating a new secure key pair
* Updating Terraform variables
* Improving `.gitignore` protections
* Moving private keys outside the repository structure

This experience reinforced the importance of secure credential handling and repository hygiene in Infrastructure as Code projects.

---

# Free Tier and Budget Constraints

The infrastructure was intentionally designed around AWS Free Tier limitations.

This introduced several architectural constraints:

* Limited instance types (`t2.micro`)
* Single Availability Zone deployment
* No NAT Gateway deployment
* No managed databases
* No load balancers
* No Kubernetes cluster deployment
* Minimal EC2 footprint

The decision to avoid a NAT Gateway was especially important because NAT resources can generate unexpected costs outside Free Tier coverage.

Infrastructure creation and destruction cycles were also carefully controlled to avoid unnecessary billing.

---

# Simplified IAM Implementation

The IAM module was intentionally implemented with a minimal foundational design.

The project demonstrates:

* IAM Role creation
* EC2 Instance Profiles
* Secure EC2 identity attachment

However, the IAM Role does not yet include advanced production-level permissions or restrictive custom policies.

This decision was made intentionally to keep the infrastructure lightweight, readable, and focused on foundational cloud concepts during the initial implementation stage.

Future improvements could include:

* CloudWatch integration
* SSM Session Manager policies
* Fine-grained S3 permissions
* Multi-role separation
* MFA-enforced workflows

---

# Single Environment Deployment

The current project only implements a single environment:

```txt id="m34s1j"
dev
```

Additional environments such as:

```txt id="cd5v8d"
staging
production
```

were intentionally excluded from the first implementation phase to reduce complexity and maintain focus on the core infrastructure concepts.

The modular Terraform structure was designed to support future multi-environment expansion if needed.

---

# Limited High-Availability Features

To remain within Free Tier and reduce unnecessary complexity, the infrastructure does not currently include:

* Multi-AZ redundancy
* Auto Scaling Groups
* Elastic Load Balancers
* Managed database replication
* Cross-region failover
* Disaster recovery architecture

The current architecture focuses on foundational Infrastructure as Code principles rather than production-grade high availability.

---

# Operational Scope Limitations

This project focuses primarily on:

* Networking
* Security Groups
* Terraform modularity
* IAM basics
* EC2 provisioning
* Remote state management

The project does not currently implement:

* CI/CD pipelines
* Kubernetes orchestration
* Monitoring dashboards
* Centralized logging
* Containerization
* Configuration management tools
* Automated testing frameworks

These features were intentionally deferred to future phases in order to maintain a clear learning scope and manageable infrastructure complexity.

---

# Documentation and Evidence Constraints

Because infrastructure resources were intentionally controlled to minimize AWS costs, the infrastructure lifecycle was planned carefully around limited apply and destroy windows.

As a result:

* Evidence collection had to be organized before deployment
* Screenshots and outputs were planned strategically
* Terraform apply operations were minimized
* Infrastructure runtime duration was intentionally reduced

This constraint influenced the project workflow and reinforced disciplined Infrastructure as Code practices.

---

# Final Considerations

Despite the operational and environmental limitations encountered during development, the project successfully demonstrates:

* Terraform modular infrastructure design
* AWS networking fundamentals
* Public and private subnet architecture
* Security Group isolation
* IAM integration concepts
* Remote state management
* Infrastructure reproducibility
* Cloud troubleshooting and debugging workflows

The limitations documented in this file reflect realistic engineering constraints rather than conceptual-only laboratory conditions, making the overall learning process significantly more practical and valuable.


