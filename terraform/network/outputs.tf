output "foundation_name" {
  description = "Name of the foundation project."
  value       = var.project_name
}

output "foundation_environment" {
  description = "Environment name for this foundation."
  value       = var.environment
}

output "aws_region" {
  description = "AWS region where the foundation is deployed."
  value       = var.aws_region
}

output "availability_zone" {
  description = "Availability Zone used by the foundation subnets."
  value       = var.availability_zone
}

output "vpc_id" {
  description = "ID of the foundation VPC."
  value       = aws_vpc.platform.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the foundation VPC."
  value       = aws_vpc.platform.cidr_block
}

output "public_subnet_id" {
  description = "ID of the public subnet used for NAT Gateway placement."
  value       = aws_subnet.public.id
}

output "public_subnet_cidr_block" {
  description = "CIDR block of the public subnet."
  value       = aws_subnet.public.cidr_block
}

output "private_subnet_id" {
  description = "ID of the private subnet used for lab workloads."
  value       = aws_subnet.private.id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs available to downstream labs."
  value       = [aws_subnet.private.id]
}

output "private_subnet_cidr_block" {
  description = "CIDR block of the private subnet."
  value       = aws_subnet.private.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway."
  value       = aws_internet_gateway.platform.id
}

output "nat_eip_allocation_id" {
  description = "Allocation ID of the Elastic IP used by the NAT Gateway."
  value       = aws_eip.nat.allocation_id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway used for private subnet outbound access."
  value       = aws_nat_gateway.platform.id
}

output "public_route_table_id" {
  description = "ID of the public route table."
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID of the private route table."
  value       = aws_route_table.private.id
}

output "s3_gateway_endpoint_id" {
  description = "ID of the S3 Gateway VPC Endpoint."
  value       = aws_vpc_endpoint.s3.id
}

output "management_security_group_id" {
  description = "Security group ID for management access patterns."
  value       = aws_security_group.mgmt.id
}

output "cluster_security_group_id" {
  description = "Security group ID intended for cluster or lab workloads."
  value       = aws_security_group.cluster.id
}

output "foundation" {
  description = "Grouped foundation values for downstream Terraform labs."

  value = {
    name                         = var.project_name
    environment                  = var.environment
    aws_region                   = var.aws_region
    availability_zone            = var.availability_zone
    vpc_id                       = aws_vpc.platform.id
    vpc_cidr_block               = aws_vpc.platform.cidr_block
    public_subnet_id             = aws_subnet.public.id
    public_subnet_cidr_block     = aws_subnet.public.cidr_block
    private_subnet_id            = aws_subnet.private.id
    private_subnet_ids           = [aws_subnet.private.id]
    private_subnet_cidr_block    = aws_subnet.private.cidr_block
    internet_gateway_id          = aws_internet_gateway.platform.id
    nat_gateway_id               = aws_nat_gateway.platform.id
    nat_eip_allocation_id        = aws_eip.nat.allocation_id
    public_route_table_id        = aws_route_table.public.id
    private_route_table_id       = aws_route_table.private.id
    s3_gateway_endpoint_id       = aws_vpc_endpoint.s3.id
    management_security_group_id = aws_security_group.mgmt.id
    cluster_security_group_id    = aws_security_group.cluster.id
  }
}
