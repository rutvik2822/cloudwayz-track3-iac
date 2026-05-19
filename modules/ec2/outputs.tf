output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IP address of EC2 instance"
  value       = aws_instance.this.public_ip
}

output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.this.id
}

output "instance_arn" {
  description = "EC2 instance ARN"
  value       = aws_instance.this.arn
}