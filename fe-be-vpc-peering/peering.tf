
#############################################################
# Inter-Region VPC Peering: Singapore <-> Tokyo
# Workspace: vpc-peering-ws
#############################################################

# 1. Backend Singapore -> Frontend Tokyo (Requester)
resource "aws_vpc_peering_connection" "fevpc_peering_bevpc" {
  vpc_id      = data.aws_vpc.backend_vpc.id #Singapore VPC
  peer_vpc_id = data.aws_vpc.frontend_vpc.id #Tokyo VPC
  peer_region = "us-east-1" # Virginia region (for OPA VCS testing)
  auto_accept = false

  tags = {
    Name = "fe-be-vpc-peering-inter"
  }
}

# 2. Frontend Tokyo accepts the request
resource "aws_vpc_peering_connection_accepter" "fevpc_accept_bevpc" {
  region                    = "ap-northeast-1"
  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
  auto_accept               = true

  tags = {
    Name = "fe-be-vpc-peering-inter"
  }
}

#############################################################
# 3. Route Tables
#############################################################

#FE Private Subnet 02 -> BE Private Subnet 02
resource "aws_route" "fevpc_private_subnet02_to_bevpc_private_subnet02" {
  region                    = "ap-northeast-1"
  route_table_id            = data.aws_route_table.frontend_private_rtb02.id
  destination_cidr_block    = "192.168.254.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}

#BE Private Subnet 02 -> FE Private Subnet 02
resource "aws_route" "bevpc_private_subnet02_to_fevpc_private_subnet02" {
  region                    = "ap-southeast-1"
  route_table_id            = data.aws_route_table.backend_private_rtb02.id
  destination_cidr_block    = "10.0.254.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}

#FE Private Subnet 03 -> BE Private Subnet 03
resource "aws_route" "fevpc_private_subnet03_to_bevpc_private_subnet03" {
  region                    = "ap-northeast-1"
  route_table_id            = data.aws_route_table.frontend_private_rtb03.id
  destination_cidr_block    = "192.168.255.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}

#BE Private Subnet 03 -> FE Private Subnet 03
resource "aws_route" "bevpc_private_subnet03_to_fevpc_private_subnet03" {
  region                    = "ap-southeast-1"
  route_table_id            = data.aws_route_table.backend_private_rtb03.id
  destination_cidr_block    = "10.0.255.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}
