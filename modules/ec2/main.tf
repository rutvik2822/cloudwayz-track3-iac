# -----------------------------
# Get Latest Amazon Linux 2023 AMI
# -----------------------------
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# -----------------------------
# Security Group
# -----------------------------
resource "aws_security_group" "this" {
  name        = "${var.project_name}-sg"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id

  # -----------------------------
  # SSH Access
  # -----------------------------
  ingress {
    description = "SSH access"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [var.ssh_cidr]
  }

  # -----------------------------
  # HTTP Access
  # -----------------------------
  ingress {
    description = "HTTP access"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [var.http_cidr]
  }

  # -----------------------------
  # Outbound Internet Access
  # -----------------------------
  egress {
    description = "Allow outbound traffic"

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# -----------------------------
# EC2 Instance
# -----------------------------
resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]

  iam_instance_profile = var.instance_profile_name

  associate_public_ip_address = true

  key_name = var.key_pair_name

  tags = {
    Name        = "${var.project_name}-ec2"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}