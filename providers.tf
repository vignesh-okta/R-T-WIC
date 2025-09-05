terraform {
  required_version = ">= 1.1.4"

  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 5.4.0"
    }
  }
}

#Configure the Okta Provider
provider "okta" {
}

