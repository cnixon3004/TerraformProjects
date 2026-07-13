output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "ARN of the created VPC"
  value       = aws_vpc.main.arn
}

output "vpc_cidr" {
  description = "CIDR block of the created VPC"
  value       = aws_vpc.main.cidr_block
}

output "account_id" {
  description = "The AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
  sensitive   = true
}

output "region_name" {
  description = "The current AWS region"
  value       = data.aws_region.current.region
}

output "available_azs" {
  description = "List of available AZs"
  value       = data.aws_availability_zones.available.names
}

output "caller_user_id" {
  value = data.aws_caller_identity.current.user_id
}

output "combined_info" {
  description = "Combined region and account information"
  value       = "${data.aws_caller_identity.current.user_id}-${data.aws_region.current.region}"
  sensitive   = true
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}

output "route_table_id" {
  description = "ID of the main route table"
  value       = aws_route_table.main.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.Testing.id
}