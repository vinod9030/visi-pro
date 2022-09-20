variable "aws_region" {}

locals {
  # S3
  s3-webhost-bucket-name       = "visi-pro-frontend-dev"
  s3-webhost-iam-policy        = "visi-pro-frontend-deploy-policy-dev"

  # EC2
  Linux-ami-id                = "ami-05fa00d4c63e32376"   # AMI needs to be in the same region, can be found in AMI Catalog in AWS
  ec2-instance-type            = "t2.micro"
  ec2-termination-protection   = true
  ec2-cpu-credits              = "unlimited"
  ec2-key-name                 = "visi-pro-dev"
  ec2-public-ip-flag           = true
  ec2-root-volume-size         = 30
  ec2-volume-delete-on-termination = false

  # Security Groups
  security-group-name          = "visi-pro-dev-sg" 

  # ECR
  container-registry-name = "visi-pro-dev"

}
