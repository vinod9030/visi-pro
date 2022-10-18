variable "aws" {
aws_access_key = "{APKATD7PANJR3GE2XQ2U}"
aws_secret_key = "{7k7BcYF4aDTorCxp7q/3hOHomi0PEmH4wKR5boCj}" 
aws_region = "{us-east-1}" 
}
variable "amis" {
    description = "AMIs by region"
    default = {
      us-east-1 = "ami-97785bed" # ubuntu 14.04 LTS
		  us-east-2 = "ami-f63b1193" # ubuntu 14.04 LTS
		  us-west-1 = "ami-824c4ee2" # ubuntu 14.04 LTS
		  us-west-2 = "ami-f2d3638a" # ubuntu 14.04 LTS
    }
}
vpc_cidr = "{172.31.0.0/20}"
public_subnet1_cidr = "{172.31.80.0/20}"
public_subnet2_cidr = "{172.31.32.0/20}"
public_subnet3_cidr = "{172.31.16.0/20}"
private_subnet_cidr = "{172.31.48.0/20}"
vpc_name = "{visi-pro}"
IGW_name = "{visi-proigw}"
public_subnet1_name = "{subnet1}"
public_subnet2_name = "{subnet2}"
public_subnet3_name = "{subnet3}"
private_subnet_name = "{subnet4}"
Main_Routing_Table = "{visi-pro}"
key_name = "{visi-pro}"
environment = "{dev}"
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
