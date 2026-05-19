variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket EC2 can access"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table EC2 can access"
  type        = string
}