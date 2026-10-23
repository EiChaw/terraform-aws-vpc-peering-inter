data "aws_subnet" "frontend_public_subnet01" {
  filter {
    name   = "tag:Name"
    values = ["frontend-public-subnet01-ap-northeast-1"]
  }
}

data "aws_security_group" "fe_public_sg01" {
  filter {
    name   = "group-name"
    values = ["frontend-public-security-group01"]
  }

  vpc_id = data.aws_vpc.frontend_vpc.id
}

data "aws_vpc" "frontend_vpc" {
  filter {
    name   = "tag:Name"
    values = ["frontend-vpc"]
  }
}

#private instance 1
data "aws_subnet" "frontend_private_subnet01" {
  filter {
    name   = "tag:Name"
    values = ["frontend-private-subnet01-ap-northeast-1"]
  }
}

data "aws_security_group" "fe_private_sg01" {
  filter {
    name   = "group-name"
    values = ["frontend-private-security-group01"]
  }

  vpc_id = data.aws_vpc.frontend_vpc.id
}

#private instance 2
data "aws_subnet" "frontend_private_subnet02" {
  filter {
    name   = "tag:Name"
    values = ["frontend-private-subnet02-ap-northeast-1"]
  }
}

data "aws_security_group" "fe_private_sg02" {
  filter {
    name   = "group-name"
    values = ["frontend-private-security-group02"]
  }

  vpc_id = data.aws_vpc.frontend_vpc.id
}

#private instance 3
data "aws_subnet" "frontend_private_subnet03" {
  filter {
    name   = "tag:Name"
    values = ["frontend-private-subnet03-ap-northeast-1"]
  }
}

data "aws_security_group" "fe_private_sg03" {
  filter {
    name   = "group-name"
    values = ["frontend-private-security-group03"]
  }

  vpc_id = data.aws_vpc.frontend_vpc.id
}