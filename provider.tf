terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.35.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
    access_key = "APKATD7PANJR3GE2XQ2U"
    secret_key = "7k7BcYF4aDTorCxp7q/3hOHomi0PEmH4wKR5boCj"
}
