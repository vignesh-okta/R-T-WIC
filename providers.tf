terraform {
  required_version = ">= 1.1.4"

  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 5.4.0"
    }
  }

  backend "s3" {
    bucket = "oktatf"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}

#Configure the Okta Provider
provider "okta" {
}

