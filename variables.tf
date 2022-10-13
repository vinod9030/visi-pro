variable "aws_access_key=AKIATD7PANJR7U5PA3WD" {}
variable "aws_secret_key=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" {}
variable "aws_region=us-east-1" {}
variable "amis" {
    description = "AMIs by region"
    default = {
        us-east-1 = "ami-97785bed" # ubuntu 14.04 LTS
		us-east-2 = "ami-f63b1193" # ubuntu 14.04 LTS
		us-west-1 = "ami-824c4ee2" # ubuntu 14.04 LTS
		us-west-2 = "ami-f2d3638a" # ubuntu 14.04 LTS
    }
}
variable "vpc_cidr=10.1.0.0/16" {}
variable "vpc_name=terraform-aws-testing" {}
variable "IGW_name=terraform-aws-igw" {}
variable "key_name=visi-pro" {}
variable "public_subnet1_cidr=10.1.1.0/24" {}
variable "public_subnet2_cidr=10.1.2.0/24" {}
variable "public_subnet3_cidr=10.1.3.0/24" {}
variable "private_subnet_cidr=10.1.20.0/24" {}
variable "public_subnet1_name=Terraform_Public_Subnet1-testing" {}
variable "public_subnet2_name=Terraform_Public_Subnet2-testing" {}
variable "public_subnet3_name=Terraform_Public_Subnet3-testing" {}
variable "private_subnet_name=Terraform_Public_Subnet-testing" {}
variable "Main_Routing_Table=Terraform_Main_table-testing" {}
variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "environment" { default = "dev" }
variable "instance_type" {
  
  default = {
    dev = "t2.nano"
    test = "t2.micro"
    prod = "t2.medium"
    }
}
