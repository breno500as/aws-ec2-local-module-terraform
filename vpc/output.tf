output "subnet_id" {
  description = "Subnet id"
  value       = aws_subnet.subnet.id
}


output "security_group_id" {
  description = "Security Group id"
  value       = aws_security_group.security_group.id
}

 