# AWS Free Tier Terraform Infrastructure

A beginner-friendly and production-aware AWS infrastructure project built using Terraform.

This project demonstrates modular Infrastructure as Code (IaC) practices while staying within AWS Free Tier limits.

---

# Architecture Overview

This infrastructure includes:

- Custom VPC
- Public and private subnets
- Internet Gateway
- Public route table
- EC2 t3.micro instance
- Security Group
- IAM Role and Instance Profile
- Private S3 bucket with:
  - server-side encryption
  - lifecycle cleanup policy
  - public access blocked
- DynamoDB table using PAY_PER_REQUEST
- Reusable Terraform modules

---

# Architecture Diagram

```text
Internet
   │
   ▼
Internet Gateway
   │
   ▼
Public Subnet
   └── EC2 t3.micro
         ├── Security Group
         └── IAM Instance Profile
                 ├── S3 Access
                 └── DynamoDB Access

Private Subnet
   └── Reserved for future internal resources

S3 Bucket
   ├── Encryption Enabled
   ├── Public Access Blocked
   └── Lifecycle Cleanup Policy

DynamoDB Table
   └── PAY_PER_REQUEST Billing
```

---

# Project Structure

```text
cloudwayz-track3-iac/
│
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── README.md
├── PROMPTS.md
├── terraform.tfstate
├── terraform.tfstate.backup
├── .terraform.lock.hcl
│
├── modules/
│   ├── network/
│   ├── storage/
│   ├── iam/
│   └── ec2/
```

---

# Modules

## Network Module

Creates:
- VPC
- Public subnet
- Private subnet
- Internet Gateway
- Route table

## Storage Module

Creates:
- Private S3 bucket
- S3 encryption
- Lifecycle cleanup policy
- DynamoDB table

## IAM Module

Creates:
- EC2 IAM role
- Least privilege policy
- IAM instance profile

## EC2 Module

Creates:
- EC2 t3.micro
- Security Group
- Amazon Linux AMI lookup
- IAM profile attachment

---

# AWS Free Tier Awareness

This project is intentionally designed to stay within AWS Free Tier limits.

Included:
- t3.micro EC2 instance
- DynamoDB PAY_PER_REQUEST
- Simple networking
- No NAT Gateway
- No Load Balancer
- No Auto Scaling
- No expensive managed services

Always monitor your AWS Billing Dashboard during testing.

---

# Cost-Control Mechanism

The project is designed with cost awareness in mind:

- Avoids NAT Gateway charges
- Uses Free Tier eligible resources
- Uses DynamoDB PAY_PER_REQUEST
- Includes S3 lifecycle cleanup policy

Recommended:
- Configure an AWS Budget alert for additional protection

---

# Security Considerations

This project follows beginner-friendly security best practices:

- S3 public access blocked
- S3 encryption enabled
- IAM least privilege permissions
- No hardcoded AWS credentials
- EC2 uses IAM Role instead of access keys
- Minimal Security Group rules
- Dynamic Amazon Linux AMI lookup
- Terraform variables used instead of hardcoded values

Recommended improvement:
- Restrict SSH access to your public IP only

Example:

```bash
YOUR_PUBLIC_IP/32
```

---

# Prerequisites

AWS Region used for deployment:

```text
ap-south-1 (Mumbai)
```

Before deploying, install:

- Terraform
- AWS CLI
- AWS account
- Configured AWS credentials
- Existing EC2 Key Pair

Verify installation:

```bash
terraform -version
aws --version
```

Configure AWS credentials:

```bash
aws configure
```

---

# Terraform Commands

## Initialize Terraform

```bash
terraform init
```

## Validate Configuration

```bash
terraform validate
```

## Preview Infrastructure Changes

```bash
terraform plan
```

## Deploy Infrastructure

```bash
terraform apply
```

## Destroy Infrastructure

```bash
terraform destroy
```

---

# Clean Destroy Support

The infrastructure is designed for clean removal using:

```bash
terraform destroy
```

Features supporting clean destroy:
- Proper Terraform dependencies
- Reusable modules
- S3 force_destroy
- Minimal resource coupling

---

# Best Practices Used

- Modular Terraform structure
- Reusable variables and outputs
- Least privilege IAM
- Resource tagging
- Dynamic AMI lookup
- Secure default S3 configuration
- Free Tier friendly architecture

---

# Future Improvements

Possible future enhancements:

- Remote Terraform state with S3 backend
- CloudWatch monitoring
- HTTPS with Load Balancer
- Auto Scaling
- CI/CD integration
- Multi-environment setup

---

# AI-Assisted Development

This project was developed using AI-assisted workflows alongside manual engineering review.

AI tools were used for:
- Terraform module scaffolding
- architecture brainstorming
- documentation assistance
- infrastructure refinement

All generated code was manually reviewed and refined for:
- AWS Free Tier safety
- least privilege IAM
- secure S3 configuration
- Terraform destroy compatibility
- infrastructure simplicity and maintainability

Examples of reviewed AI-generated tradeoffs:
- globally open SSH access (0.0.0.0/0)
- IAM permission scope
- S3 destroy behavior
- lifecycle policy configuration

This project intentionally emphasizes engineering judgment rather than blindly accepting AI-generated output.

---

# Disclaimer

This project is intended for:
- learning Terraform
- internship challenges
- AWS infrastructure practice
- beginner cloud engineering portfolios

It is intentionally simple to remain understandable, cost-effective, and easy to maintain.