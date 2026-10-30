terraform {
  required_version = ">= 1.8.5"

  cloud {
    organization = "eec_hc_lab"
    workspaces {
      name = "opa-vcs-be-network"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
