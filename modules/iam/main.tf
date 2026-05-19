# -----------------------------
# IAM Role for EC2
# -----------------------------
resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-ec2-role"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# -----------------------------
# Custom Least Privilege Policy
# -----------------------------
resource "aws_iam_policy" "ec2_policy" {
  name        = "${var.project_name}-ec2-policy"
  description = "Least privilege policy for EC2 access to S3 and DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      # -----------------------------
      # S3 Permissions
      # -----------------------------
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]

        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*"
        ]
      },

      # -----------------------------
      # DynamoDB Permissions
      # -----------------------------
      {
        Effect = "Allow"

        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]

        Resource = var.dynamodb_table_arn
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-ec2-policy"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# -----------------------------
# Attach Policy to Role
# -----------------------------
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

# -----------------------------
# IAM Instance Profile
# -----------------------------
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.ec2_role.name

  tags = {
    Name        = "${var.project_name}-instance-profile"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}