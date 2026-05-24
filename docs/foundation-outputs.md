# Foundation Outputs

This document defines what downstream Terraform labs can depend on from `secure-aws-platform-lab`.

## Purpose

`secure-aws-platform-lab` provides a reusable AWS network foundation for future infrastructure labs.

The foundation owns:

- VPC
- Public subnet
- Private subnet
- Internet Gateway
- NAT Gateway
- Public and private route tables
- S3 Gateway VPC Endpoint
- Management security group
- Cluster security group

Downstream labs should consume these values through Terraform outputs rather than recreating the network.

## First Downstream Consumer

The first planned downstream consumer is:

```text
terraform-aws-kubeadm-cka-lab
