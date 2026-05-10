
# Troubleshooting and Issue Resolution

## Introduction

This document describes the main technical issues encountered during the development of the Terraform AWS Infrastructure project and explains how each issue was investigated and resolved.

The purpose of this section is to document the real troubleshooting process followed during the implementation of the infrastructure rather than presenting the project as a perfectly linear deployment.

Cloud engineering and Infrastructure as Code workflows frequently involve debugging provider issues, backend configuration problems, authentication mistakes, and dependency resolution challenges. Documenting these situations is an important part of demonstrating practical infrastructure experience.

---

# Terraform Backend Region Mismatch

## Problem

During the initial Terraform backend configuration, Terraform returned the following error:

```txt id="vljlwm"
requested bucket from "us-east-1", actual location "us-west-2"
````

Terraform failed while attempting to initialize the remote S3 backend.

---

# Root Cause

The backend configuration initially referenced a placeholder S3 bucket name:

```txt id="nwxrwj"
my-terraform-state-bucket
```

The bucket already existed globally in another AWS account and was located in a different AWS region.

Amazon S3 bucket names are globally unique, which means Terraform attempted to communicate with an external bucket outside the project environment.

---

# Resolution

The issue was resolved by:

* Creating a dedicated S3 bucket owned by the current AWS account
* Updating the backend region configuration
* Reinitializing Terraform after backend changes

New backend configuration:

```txt id="jlwm215"
bucket = "dayana-terraform-state-017562255060"
region = "us-east-1"
```

Terraform backend initialization completed successfully afterward.

---

# AccessDenied Errors During Backend Initialization

## Problem

After correcting the backend region, Terraform produced additional errors:

```txt id="e48mfx"
AccessDenied
```

AWS CLI commands also failed:

```bash id="jhm9n9"
aws s3 ls s3://my-terraform-state-bucket
```

and:

```bash id="3u7ay9"
aws s3api get-bucket-location
```

---

# Root Cause

The placeholder bucket belonged to another AWS account and the current IAM user did not have permissions to access it.

This confirmed that the original bucket reference was invalid for the project environment.

---

# Resolution

The solution included:

* Creating a new project-specific S3 bucket
* Updating backend configuration
* Cleaning local Terraform backend metadata

Terraform was reinitialized after deleting the local `.terraform` directory:

```bash id="jlwm216"
rm -rf .terraform
terraform init
```

---

# Terraform Module Not Installed Error

## Problem

Terraform validation initially failed with:

```txt id="49jjyv"
Module not installed
```

Terraform could not locate the local module dependencies.

---

# Root Cause

New Terraform modules had been added but Terraform initialization had not been rerun afterward.

Terraform requires module initialization whenever new modules are introduced.

---

# Resolution

The issue was resolved by executing:

```bash id="jlwm217"
terraform init
```

from the correct environment directory:

```txt id="8ruvwj"
environments/dev
```

Terraform successfully downloaded and initialized the module dependencies afterward.

---

# Reference to Undeclared Module Error

## Problem

Terraform validation produced the following error:

```txt id="jlwm218"
Reference to undeclared module
```

Specifically:

```txt id="9v1tga"
No module call named "compute" is declared in the root module.
```

---

# Root Cause

Outputs inside `outputs.tf` referenced:

```txt id="jlwm219"
module.compute
```

before the compute module had actually been declared inside `main.tf`.

---

# Resolution

The issue was resolved by adding the compute module declaration inside:

```txt id="hawmtu"
environments/dev/main.tf
```

Terraform validation succeeded after the module was properly connected.

---

# Terraform State Reinitialization Issues

## Problem

After backend changes, Terraform behavior became inconsistent during initialization.

---

# Root Cause

Terraform caches backend metadata and provider information inside:

```txt id="f1gz9q"
.terraform/
```

Old cached backend configuration conflicted with the updated backend settings.

---

# Resolution

The local Terraform cache was removed:

```bash id="jlwm220"
rm -rf .terraform
```

Terraform was then reinitialized successfully.

---

# SSH Key Exposure Incident

## Problem

An SSH private key (`.pem`) was accidentally committed before `.gitignore` protections were fully configured.

This created a significant security risk because the private key became exposed within the repository history.

---

# Root Cause

The `.gitignore` file had been configured after the key file had already been tracked by Git.

Git continues tracking previously committed files even after `.gitignore` rules are added.

---

# Resolution

The issue was mitigated through several steps:

* Deleting the compromised key pair from AWS
* Removing the local `.pem` file
* Creating a new secure key pair
* Updating Terraform variables
* Adding `.pem` files to `.gitignore`
* Removing tracked sensitive files from Git history
* Moving private keys outside the repository structure

This process reinforced proper credential management practices for Infrastructure as Code workflows.

---

# Terraform Git Tracking Issues

## Problem

Sensitive files continued appearing in Git even after being added to `.gitignore`.

---

# Root Cause

Git does not automatically stop tracking files that were already committed before `.gitignore` rules existed.

---

# Resolution

Tracked files were manually removed from Git indexing using:

```bash id="jlwm221"
git rm --cached
```

This removed sensitive files from repository tracking while preserving local copies.

---

# Terraform Backend Organization Confusion

## Problem

Confusion occurred regarding why `backend.tf` appeared empty while Terraform backend configuration still worked.

---

# Root Cause

Terraform merges all `.tf` files automatically during execution.

The backend configuration still existed inside another file (`provider.tf`), so Terraform continued functioning correctly even though `backend.tf` itself was empty.

---

# Resolution

The backend configuration was reorganized conceptually to improve repository structure clarity.

Responsibilities were separated into:

* `backend.tf`
* `provider.tf`

This improved readability and aligned the project structure with common Terraform repository conventions.

---

# IAM Integration Dependency Adjustments

## Problem

After introducing the IAM module, EC2 resources initially lacked proper IAM attachment integration.

---

# Root Cause

The compute module had not yet been updated to receive the IAM Instance Profile variable.

The IAM module existed independently but was not connected to EC2 resources.

---

# Resolution

The following changes were implemented:

* Added IAM Instance Profile variable to compute module
* Attached IAM Instance Profile to EC2 resources
* Connected IAM outputs to compute module inputs
* Updated root environment module wiring

Terraform plan then correctly displayed:

```txt id="jlwm222"
iam_instance_profile
```

inside the EC2 resources.

---

# VPN and Connectivity Challenges

## Problem

Cloud connectivity occasionally behaved inconsistently during provider initialization and AWS communication.

---

# Root Cause

VPN routing variability and internet restrictions introduced occasional instability during Terraform operations.

These conditions affected:

* Provider downloads
* Terraform initialization
* SSH IP consistency
* AWS API communication

---

# Resolution

The workflow was stabilized by:

* Reinitializing Terraform when necessary
* Avoiding unnecessary apply cycles
* Planning infrastructure carefully before deployment
* Maintaining reproducible Terraform scripts
* Structuring evidence collection before infrastructure creation

---

# Cost Management Considerations

## Problem

AWS billing risk was a major concern during development.

---

# Root Cause

Cloud infrastructure can generate costs unexpectedly, especially when NAT Gateways or unmanaged runtime resources remain active.

---

# Resolution

Several architectural decisions were made intentionally to reduce cost exposure:

* Using Free Tier-compatible EC2 instances
* Avoiding NAT Gateway deployment
* Minimizing infrastructure runtime duration
* Planning apply operations carefully
* Using Terraform destroy for cleanup
* Creating AWS budget monitoring

---

# Final Troubleshooting Summary

The troubleshooting process during this project involved realistic cloud engineering challenges including:

* Terraform backend configuration issues
* AWS permission conflicts
* Module dependency problems
* Security and credential management mistakes
* Terraform state inconsistencies
* Git tracking behavior
* IAM integration dependencies
* VPN-related operational instability

Resolving these issues helped reinforce practical understanding of:

* Terraform workflows
* AWS backend architecture
* Infrastructure modularity
* Cloud security practices
* Infrastructure reproducibility
* Operational debugging techniques

The final environment became significantly more stable, organized, and secure as a result of the troubleshooting and iterative refinement process.

