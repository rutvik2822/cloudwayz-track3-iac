variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name"
  type        = string
}

variable "key_pair_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR block allowed to SSH into EC2"

  type    = string
  default = "0.0.0.0/0"
}

variable "http_cidr" {
  description = "CIDR block allowed for HTTP access"

  type    = string
  default = "0.0.0.0/0"
}