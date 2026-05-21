# ==============================================================================
# Secure AWS Platform Lab Security Groups
# ==============================================================================

resource "aws_security_group" "mgmt" {
  name        = "secure-aws-mgmt-sg"
  description = "Secure AWS Platform Lab: Management tier security group for SSM-managed administrative nodes. No inbound access permitted."
  vpc_id      = aws_vpc.platform.id

  tags = {
    Name = "secure-aws-mgmt-sg"
    Tier = "management"
  }
}

resource "aws_security_group" "cluster" {
  name        = "secure-aws-cluster-sg"
  description = "Secure AWS Platform Lab: Internal cluster communication group. Enables east-west traffic between nodes within the same security boundary."
  vpc_id      = aws_vpc.platform.id

  tags = {
    Name = "secure-aws-cluster-sg"
    Tier = "cluster"
  }
}

# ==============================================================================
# Management Security Group Rules
# ==============================================================================

# No inbound rules are defined for the management security group.
# Administrative access is handled through AWS Systems Manager Session Manager.

resource "aws_vpc_security_group_egress_rule" "mgmt_http" {
  security_group_id = aws_security_group.mgmt.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allows outbound metadata sync and mirror redirection for standard software repositories."

  tags = {
    Name = "secure-aws-mgmt-egress-http"
  }
}

resource "aws_vpc_security_group_egress_rule" "mgmt_https" {
  security_group_id = aws_security_group.mgmt.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_ipv4   = "0.0.0.0/0"

  description = "Required for SSM Agent connectivity and encrypted software repository updates."

  tags = {
    Name = "secure-aws-mgmt-egress-https"
  }
}

# ==============================================================================
# Cluster Security Group Rules
# ==============================================================================

resource "aws_vpc_security_group_ingress_rule" "cluster_from_mgmt_all" {
  security_group_id            = aws_security_group.cluster.id
  referenced_security_group_id = aws_security_group.mgmt.id

  ip_protocol = "-1"

  description = "Enables unrestricted communication between all nodes assigned to this security group."

  tags = {
    Name = "secure-aws-cluster-ingress-from-mgmt-all"
  }
}

resource "aws_vpc_security_group_egress_rule" "cluster_http" {
  security_group_id = aws_security_group.cluster.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allows outbound metadata sync for standard software repositories."

  tags = {
    Name = "secure-aws-cluster-egress-http"
  }
}

resource "aws_vpc_security_group_egress_rule" "cluster_https" {
  security_group_id = aws_security_group.cluster.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_ipv4   = "0.0.0.0/0"

  description = "Required for secure software updates and AWS API communication."

  tags = {
    Name = "secure-aws-cluster-egress-https"
  }
}
