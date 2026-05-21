#!/bin/bash
#
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Travis Whitlock
#
# dump-vpc.sh
#
# Purpose:
#   Capture a point-in-time AWS VPC configuration snapshot using the AWS CLI.
#
#   This script is intended for infrastructure discovery, Terraform validation,
#   and before/after comparison when rebuilding AWS network resources as code.
#
# What this script does:
#   - Sources runtime settings from a user-provided configuration file.
#   - Runs selected AWS EC2 describe commands.
#   - Writes each command's output to a separate JSON file.
#
# What this script does not do:
#   - It does not create, modify, or delete AWS resources.
#   - It does not convert AWS JSON output into Terraform configuration.
#   - It does not filter all resources by VPC ID because AWS describe commands
#     do not all support the same filter parameters.
#
# Required config file variables:
#   VPC_ID        The VPC ID used as a reference for targeted discovery.
#   PROFILE_NAME The AWS CLI profile used to authenticate requests.
#
# Optional config file variables:
#   OUTPUT_TYPE   AWS CLI output format. Defaults to json if not provided.
#
# Example config file:
#   VPC_ID=vpc-0123456789abcdef0
#   PROFILE_NAME=my-aws-profile
#   OUTPUT_TYPE=json
#
# Usage:
#   ./dump-vpc.sh ./dump-vpc.conf
#
# Output:
#   The script writes JSON files into the current working directory.
#   Example:
#     describe-vpcs.json
#     describe-subnets.json
#     describe-route-tables.json
#
# Public repository note:
#   Discovery output may contain AWS account IDs, resource IDs, ARNs, security
#   group rules, CIDR ranges, tags, and other environment-specific details.
#   Review generated JSON files carefully before committing them to a public repo.
#

# Define config file location
CONFIG_FILE="$1"

# Validate input
if [ -z "$CONFIG_FILE" ]; then
    echo "Usage: $0 <config-file>" >&2
    exit 1
fi

# Source config file
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Error: config file not found: $CONFIG_FILE" >&2
    exit 1
fi

# Validate required config values
: "${VPC_ID:?VPC_ID is required}"
: "${PROFILE_NAME:?PROFILE_NAME is required}"
: "${OUTPUT_TYPE:=json}"

# AWS EC2 configuration objects to capture
EC2_CONFIG_OBJECTS=(
    "describe-vpcs"
    "describe-subnets"
    "describe-route-tables"
    "describe-security-groups"
    "describe-internet-gateways"
    "describe-nat-gateways"
    "describe-vpc-endpoints"
    "describe-addresses"
    "describe-network-acls"
    "describe-tags"
)

for cmd in "${EC2_CONFIG_OBJECTS[@]}"; do
    echo "Capturing $cmd..."
    aws ec2 "$cmd" \
	    --profile "$PROFILE_NAME" \
	    --output "$OUTPUT_TYPE" \
	    > "${cmd}.json"
done

echo "Configuration dump complete."
