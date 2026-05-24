# Secure AWS Platform Lab

Secure AWS Platform Lab is a Terraform-managed infrastructure project for building a private, hardened AWS platform foundation. The project focuses on secure VPC networking, SSM-first administrative access, controlled outbound egress, and repeatable infrastructure deployment.

The long-term goal is to use this foundation to support Kubernetes platform engineering and future AI infrastructure experiments while maintaining secure cloud design principles.

## Current Status

The initial network foundation has been built manually, documented, deleted, and successfully recreated using Terraform.

Current phase:

- Terraform-managed AWS network foundation
- Private subnet architecture
- No inbound administrative access
- AWS Systems Manager Session Manager access model
- Controlled outbound internet access through NAT Gateway
- S3 Gateway Endpoint for AWS-internal S3 routing
- Security groups for management and cluster tiers

## Architecture Overview

This project creates a small but intentionally designed AWS network environment:

- Custom VPC
- Public subnet for NAT Gateway placement
- Private subnet for future EC2 and Kubernetes nodes
- Internet Gateway for public subnet egress
- NAT Gateway with Elastic IP for private subnet outbound access
- Public and private route tables
- S3 Gateway VPC Endpoint
- Management security group with no inbound rules
- Cluster security group with controlled internal access

The environment is designed around a no-SSH administrative model. Instances are expected to be managed through AWS Systems Manager rather than public IP addresses, bastion hosts, or static SSH key pairs.

## Security Principles

This project follows several core security principles:

- No inbound administrative ports
- No public IP addresses on private workload nodes
- Identity-driven access through AWS Systems Manager
- Explicit VPC, subnet, route table, and security group definitions
- Controlled egress from private subnets
- Infrastructure defined and reviewed before deployment
- Terraform plan review before apply

## Repository Structure

```text
secure-aws-platform-lab/
  README.md
  .gitignore
  terraform/
    network/
      providers.tf
      variables.tf
      network.tf
      security-groups.tf
      terraform.tfvars.example
  scripts/
    dump-vpc.sh
    dump-vpc.conf.example
  discovery/
    README.md
    archive/
      README.md
  docs/
    network-rebuild-validation.md

## Foundation for Downstream Labs

This project exposes Terraform outputs that allow future infrastructure labs to consume the AWS network foundation without recreating it.

The first planned downstream consumer is:

```text
terraform-aws-kubeadm-cka-lab
