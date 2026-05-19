# PROMPTS.md

This document summarizes how AI tools were used during development of this Terraform AWS infrastructure project.

The goal was not to blindly copy AI-generated code, but to use AI as an engineering assistant while manually reviewing architecture, security, cost, and operational decisions.

---

# AI Usage Workflow

Typical workflow used during development:

1. Ask AI for Terraform module scaffolding
2. Review generated infrastructure carefully
3. Identify security or operational concerns
4. Refine implementation decisions
5. Test using terraform validate / plan / apply / destroy
6. Document engineering tradeoffs

The project intentionally focused on:
- AWS Free Tier safety
- simplicity
- maintainability
- reusable module structure
- clean destroy support

---

# Example AI Prompts Used

## Network Module Prompt

```text
Generate beginner-friendly Terraform code for a reusable network module with:

- 1 VPC
- 1 public subnet
- 1 private subnet
- Internet Gateway
- Route table for public subnet internet access

Requirements:
- AWS Free Tier safe
- avoid NAT Gateway
- clean terraform destroy support
- proper tags
- variables for CIDR blocks
- outputs for subnet IDs and VPC ID

Keep architecture intentionally simple and production-aware.
```

---

## IAM Module Prompt

```text
Generate beginner-friendly Terraform code for an IAM module for an EC2 instance.

Requirements:
- create IAM role for EC2
- attach least privilege policy
- allow EC2 to access:
  - one S3 bucket
  - one DynamoDB table
- create IAM instance profile
- avoid AdministratorAccess
- avoid wildcard "*" permissions where possible
- reusable module structure
- AWS Free Tier safe
- clean terraform destroy support
```

---

## Storage Module Prompt

```text
Generate beginner-friendly Terraform code for a reusable storage module with:

1. One private S3 bucket
2. S3 server-side encryption enabled
3. S3 public access blocked
4. S3 lifecycle policy for automatic cleanup after 30 days
5. One DynamoDB table using PAY_PER_REQUEST billing
```

---

## EC2 Module Prompt

```text
Generate beginner-friendly Terraform code for a reusable EC2 module with:

1. One EC2 t3.micro instance
2. Amazon Linux AMI lookup using data source
3. One Security Group
4. Allow:
   - SSH (22)
   - HTTP (80)
5. Attach IAM instance profile to EC2
6. Launch instance in public subnet
7. Auto-assign public IP
```

---

# Important AI-Generated Issues Reviewed

## 1. SSH Access Open to Entire Internet

AI initially generated:

```text
0.0.0.0/0
```

for SSH access.

This was acceptable for testing purposes but identified as a production security concern.

Production recommendation:
- restrict SSH access to trusted public IP ranges only

Example:

```text
YOUR_PUBLIC_IP/32
```

---

## 2. IAM Least Privilege Review

AI-generated IAM policies were manually reviewed to avoid:
- wildcard permissions
- AdministratorAccess
- unnecessary AWS actions

The final implementation used:
- specific S3 permissions
- specific DynamoDB permissions
- EC2 IAM Role + Instance Profile

instead of hardcoded credentials.

---

## 3. AWS Free Tier Cost Awareness

AI suggestions were intentionally simplified to avoid unnecessary AWS costs.

Avoided services:
- NAT Gateway
- Load Balancer
- RDS
- Auto Scaling
- multi-AZ infrastructure

The architecture intentionally stayed lightweight and Free Tier friendly.

---

## 4. S3 Destroy Behavior

AI-generated S3 configuration was reviewed for destroy compatibility.

The project intentionally uses:

```text
force_destroy = true
```

to prevent Terraform destroy failures when bucket objects exist.

---

## 5. Lifecycle Policy Review

The project includes an S3 lifecycle cleanup rule to support automated cost-control behavior.

This was intentionally chosen as a simpler and safer cost-control mechanism compared to more advanced AWS billing automation.

---

# Debugging and Operational Issues Encountered

## Terraform Module Initialization

Encountered:

```text
Module not installed
```

Resolved by:
- running terraform init after adding new modules

---

## AWS Key Pair Region Issue

EC2 deployment initially failed because:
- the EC2 key pair was created in a different AWS region

Resolved by:
- creating the key pair in ap-south-1 (Mumbai)

---

## Terraform State Recovery

After partial apply failures:
- Terraform state tracking correctly preserved existing resources
- subsequent terraform apply operations only created missing resources

This demonstrated proper Terraform dependency and state management behavior.

---

# Engineering Decisions

Key intentional decisions made during the project:

- keep infrastructure intentionally simple
- prioritize clean terraform destroy support
- avoid unnecessary AWS services
- use reusable Terraform modules
- prefer readability over overengineering
- focus on beginner-friendly but production-aware architecture

---

# Final Outcome

The final infrastructure successfully deployed:

- VPC
- public/private subnets
- Internet Gateway
- route table
- EC2 t3.micro instance
- Security Group
- IAM role and instance profile
- private encrypted S3 bucket
- DynamoDB PAY_PER_REQUEST table
- lifecycle cleanup policy

The project demonstrates:
- Infrastructure as Code
- AWS fundamentals
- Terraform modularity
- least privilege IAM
- security awareness
- cost awareness
- AI-assisted engineering workflow