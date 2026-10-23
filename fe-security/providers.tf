terraform {
  required_version = ">= 1.8.5"

  cloud {
    organization = "eec_hc_lab"
    workspaces {
      name = "fe-security-ws"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
