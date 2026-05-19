variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "Partition key for DynamoDB table"
  type        = string
  default     = "id"
}

variable "s3_lifecycle_days" {
  description = "Days before S3 objects are automatically deleted"
  type        = number
  default     = 30
}