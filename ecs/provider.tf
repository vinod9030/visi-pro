provider "aws" {
  access_key = "APKATD7PANJR3GE2XQ2U"
  secret_key = "7k7BcYF4aDTorCxp7q/3hOHomi0PEmH4wKR5boCj"
  region     = var.aws_region
  #if you are running from AWS ec2 linux instance please use bellow credentials section
  #shared_credentials_file = "$HOME/.aws/credentials"
  #profile = "default"
}
