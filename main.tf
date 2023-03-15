terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  backend "s3" {
    bucket = "rdkit-rs-tf-state"
    key = "github-actions-oidc"
    region = "eu-central-1"
    encrypt = true
    role_arn = "arn:aws:iam::989722935798:role/OrganizationAccountAccessRole"
    session_name = "rdkit-rs-terraform"
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "scientist"
  region  = "eu-central-1"

  assume_role {
    role_arn = "arn:aws:iam::989722935798:role/OrganizationAccountAccessRole"
  }

  default_tags {
    tags = {
      "scientist.com/created-by"  = "terraform"
      "scientist.com/environment" = "production"
      "scientist.com/app"         = "github-actions-oidc"
    }
  }
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
}