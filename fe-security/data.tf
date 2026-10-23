data "aws_vpc" "frontend_vpc" {
  filter {
    name   = "tag:Name"
    values = ["frontend-vpc"]
  }
}