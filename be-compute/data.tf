data "aws_subnet" "backend_public_subnet01" {
  filter {
    name   = "tag:Name"
    values = ["backend-public-subnet01-ap-southeast-1"]
  }
}

data "aws_security_group" "be_public_sg01" {
  filter {
    name   = "group-name"
    values = ["backend-public-security-group01"]
  }

  vpc_id = data.aws_vpc.backend_vpc.id
}

data "aws_vpc" "backend_vpc" {
  filter {
    name   = "tag:Name"
    values = ["backend-vpc"]
  }
}

#private instance 1
data "aws_subnet" "backend_private_subnet01" {
  filter {
    name   = "tag:Name"
    values = ["backend-private-subnet01-ap-southeast-1"]
  }
}

data "aws_security_group" "be_private_sg01" {
  filter {
    name   = "group-name"
    values = ["backend-private-security-group01"]
  }

  vpc_id = data.aws_vpc.backend_vpc.id
}

#private instance 2
data "aws_subnet" "backend_private_subnet02" {
  filter {
    name   = "tag:Name"
    values = ["backend-private-subnet02-ap-southeast-1"]
  }
}

data "aws_security_group" "be_private_sg02" {
  filter {
    name   = "group-name"
    values = ["backend-private-security-group02"]
  }

  vpc_id = data.aws_vpc.backend_vpc.id
}

#private instance 3
data "aws_subnet" "backend_private_subnet03" {
  filter {
    name   = "tag:Name"
    values = ["backend-private-subnet03-ap-southeast-1"]
  }
}

data "aws_security_group" "be_private_sg03" {
  filter {
    name   = "group-name"
    values = ["backend-private-security-group03"]
  }

  vpc_id = data.aws_vpc.backend_vpc.id
}