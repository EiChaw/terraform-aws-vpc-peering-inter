terraform {
  required_version = ">= 1.8.5"

  cloud {
    organization = "eec_hc_lab"
    workspaces {
      name = "vpc-peering-ws"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
