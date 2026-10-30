# Backend VPC - Singapore
data "aws_vpc" "backend_vpc" {
  region     = "ap-southeast-1"
  cidr_block = "192.168.0.0/16"
}

# Frontend VPC - Tokyo
data "aws_vpc" "frontend_vpc" {
  region     = "ap-northeast-1"
  cidr_block = "10.0.0.0/16"
}

#############################################################
# Frontend Route Tables - Tokyo
#############################################################

data "aws_route_table" "frontend_private_rtb02" {
  region = "ap-northeast-1"

  filter {
    name   = "tag:Name"
    values = ["frontend-private-rtb02"]
  }
}

data "aws_route_table" "frontend_private_rtb03" {
  region = "ap-northeast-1"

  filter {
    name   = "tag:Name"
    values = ["frontend-private-rtb03"]
  }
}

#############################################################
# Backend Route Tables - Singapore
#############################################################

data "aws_route_table" "backend_private_rtb02" {
  region = "ap-southeast-1"

  filter {
    name   = "tag:Name"
    values = ["backend-private-rtb02"]
  }
}

data "aws_route_table" "backend_private_rtb03" {
  region = "ap-southeast-1"

  filter {
    name   = "tag:Name"
    values = ["backend-private-rtb03"]
  }
}
