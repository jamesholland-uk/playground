# Project Details
output "projectname" {
  value = var.projectname
}

# AWS Account details
output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  value = var.aws_region
}

# VPC ID
output "vpc_id" {
  value = aws_vpc.the_vpc.id
}

# Subnet IDs
output "dmz1_subnet_id" {
  value = aws_subnet.the_dmz1.id
}
output "dmz2_subnet_id" {
  value = aws_subnet.the_dmz2.id
}
output "cloudngfw_subnet_id" {
  value = aws_subnet.the_cloudngfw_subnet.id
}

# Subnet CIDR blocks
output "dmz1_subnet_cidr_block" {
  value = aws_subnet.the_dmz1.cidr_block
}
output "dmz2_subnet_cidr_block" {
  value = aws_subnet.the_dmz2.cidr_block
}

# Route Table IDs
output "dmz1_routetable_id" {
  value = aws_route_table.dmz1_rt.id
}
output "dmz2_routetable_id" {
  value = aws_route_table.dmz2_rt.id
}
output "cloudngfw_routetable_id" {
  value = aws_route_table.cloudngfw_rt.id
}

# Host IPs
output "host1_public_ip" {
  value = aws_instance.the_host1.public_ip
}
output "host1_private_ip" {
  value = aws_instance.the_host1.private_ip
}
output "host2_public_ip" {
  value = aws_instance.the_host2.public_ip
}
output "host2_private_ip" {
  value = aws_instance.the_host2.private_ip
}

# CloudWatch Log Group
output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.cloudngfw_log_group.name
}

# Cloud NGFW Role's ARN
output "cloudngfw_role_arn" {
  value = aws_iam_role.ngfw_role.arn
}
