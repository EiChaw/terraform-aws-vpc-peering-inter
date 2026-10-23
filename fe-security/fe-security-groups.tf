
# Frontend Security Groups - Tokyo

#############################################################
# FE Public Security Group 01
#############################################################

resource "aws_security_group" "fe_public_sg01" {
  name = "${var.frontend_prefix}-public-security-group01"

  # VPC is managed by fe-network-ws
  vpc_id = data.aws_vpc.frontend_vpc.id

  tags = {
    Name = "${var.frontend_prefix}-public-security-group01"
  }
}

# Separate SSH ingress rule
resource "aws_vpc_security_group_ingress_rule" "fe_public_sg01_allow_ssh" {
  security_group_id = aws_security_group.fe_public_sg01.id
  description       = "Allow SSH"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}


# Separate ICMP ingress rule
resource "aws_vpc_security_group_ingress_rule" "fe_public_sg01_allow_icmp" {
  security_group_id = aws_security_group.fe_public_sg01.id
  description       = "Allow ICMP Echo Request"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8
  to_port           = 0
  ip_protocol       = "icmp"
}

# Separate HTTP ingress rule
resource "aws_vpc_security_group_ingress_rule" "fe_public_sg01_allow_http" {
  security_group_id = aws_security_group.fe_public_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Separate HTTPS ingress rule
resource "aws_vpc_security_group_ingress_rule" "fe_public_sg01_allow_https" {
  security_group_id = aws_security_group.fe_public_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# Separate egress rule
resource "aws_vpc_security_group_egress_rule" "fe_public_sg01_allow_all_traffic" {
  security_group_id = aws_security_group.fe_public_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#############################################################
# FE Private Security Group 01
#############################################################

resource "aws_security_group" "fe_private_sg01" {
  name   = "${var.frontend_prefix}-private-security-group01"
  vpc_id = data.aws_vpc.frontend_vpc.id

  tags = {
    Name = "${var.frontend_prefix}-private-security-group01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "fe_private_sg01_allow_ssh" {
  security_group_id            = aws_security_group.fe_private_sg01.id
  referenced_security_group_id = aws_security_group.fe_public_sg01.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "fe_private_sg01_allow_icmp" {
  security_group_id            = aws_security_group.fe_private_sg01.id
  referenced_security_group_id = aws_security_group.fe_public_sg01.id
  from_port                    = 8
  to_port                      = 0
  ip_protocol                  = "icmp"
}

resource "aws_vpc_security_group_egress_rule" "fe_private_sg01_allow_all_traffic" {
  security_group_id = aws_security_group.fe_private_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#############################################################
# FE Private Security Group 02
#############################################################

resource "aws_security_group" "fe_private_sg02" {
  name   = "${var.frontend_prefix}-private-security-group02"
  vpc_id = data.aws_vpc.frontend_vpc.id

  tags = {
    Name = "${var.frontend_prefix}-private-security-group02"
  }
}

# SSH from FE Private SG01
resource "aws_vpc_security_group_ingress_rule" "fe_private_sg02_allow_ssh_from_fe_private_sg01" {
  security_group_id            = aws_security_group.fe_private_sg02.id
  referenced_security_group_id = aws_security_group.fe_private_sg01.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
}

# ICMP from FE Private SG01
resource "aws_vpc_security_group_ingress_rule" "fe_private_sg02_allow_icmp_from_fe_private_sg01" {
  security_group_id            = aws_security_group.fe_private_sg02.id
  referenced_security_group_id = aws_security_group.fe_private_sg01.id
  from_port                    = 8
  to_port                      = 0
  ip_protocol                  = "icmp"
}

# SSH from BE via CIDR (Inter-Region)
resource "aws_vpc_security_group_ingress_rule" "fe_private_sg02_allow_ssh_from_be" {
  security_group_id = aws_security_group.fe_private_sg02.id
  cidr_ipv4         = var.backend_vpc_address_space
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# ICMP from BE via CIDR
resource "aws_vpc_security_group_ingress_rule" "fe_private_sg02_allow_icmp_from_be" {
  security_group_id = aws_security_group.fe_private_sg02.id
  cidr_ipv4         = var.backend_vpc_address_space
  from_port         = 8
  to_port           = 0
  ip_protocol       = "icmp"
}

# SSH egress to BE via CIDR
resource "aws_vpc_security_group_egress_rule" "fe_private_sg02_allow_ssh_to_be" {
  security_group_id = aws_security_group.fe_private_sg02.id
  cidr_ipv4         = var.backend_vpc_address_space
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# CHANGED: ICMP egress to BE via CIDR
resource "aws_vpc_security_group_egress_rule" "fe_private_sg02_allow_icmp_to_be" {
  security_group_id = aws_security_group.fe_private_sg02.id
  cidr_ipv4         = var.backend_vpc_address_space
  from_port         = 8
  to_port           = 0
  ip_protocol       = "icmp"
}

#############################################################
# FE Private Security Group 03
#############################################################

resource "aws_security_group" "fe_private_sg03" {
  name   = "${var.frontend_prefix}-private-security-group03"
  vpc_id = data.aws_vpc.frontend_vpc.id

  tags = {
    Name = "${var.frontend_prefix}-private-security-group03"
  }
}

# SSH from FE Private SG01
resource "aws_vpc_security_group_ingress_rule" "fe_private_sg03_allow_ssh_from_fe_private_sg01" {
  security_group_id            = aws_security_group.fe_private_sg03.id
  referenced_security_group_id = aws_security_group.fe_private_sg01.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
}

# ICMP from FE Private SG01
resource "aws_vpc_security_group_ingress_rule" "fe_private_sg03_allow_icmp_from_fe_private_sg01" {
  security_group_id            = aws_security_group.fe_private_sg03.id
  referenced_security_group_id = aws_security_group.fe_private_sg01.id
  from_port                    = 8
  to_port                      = 0
  ip_protocol                  = "icmp"
}

# CHANGED: SSH from BE via CIDR
resource "aws_vpc_security_group_ingress_rule" "fe_private_sg03_allow_ssh_from_be" {
  security_group_id = aws_security_group.fe_private_sg03.id
  cidr_ipv4         = var.backend_vpc_address_space
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# CHANGED: ICMP from BE via CIDR
resource "aws_vpc_security_group_ingress_rule" "fe_private_sg03_allow_icmp_from_be" {
  security_group_id = aws_security_group.fe_private_sg03.id
  cidr_ipv4         = var.backend_vpc_address_space
  from_port         = 8
  to_port           = 0
  ip_protocol       = "icmp"
}

# CHANGED: SSH egress to BE via CIDR
resource "aws_vpc_security_group_egress_rule" "fe_private_sg03_allow_ssh_to_be" {
  security_group_id = aws_security_group.fe_private_sg03.id
  cidr_ipv4         = var.backend_vpc_address_space
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# CHANGED: ICMP egress to BE via CIDR
resource "aws_vpc_security_group_egress_rule" "fe_private_sg03_allow_icmp_to_be" {
  security_group_id = aws_security_group.fe_private_sg03.id
  cidr_ipv4         = var.backend_vpc_address_space
  from_port         = 8
  to_port           = 0
  ip_protocol       = "icmp"
}