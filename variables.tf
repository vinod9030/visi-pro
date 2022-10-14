variable "aws_access_key = APKATD7PANJR3GE2XQ2U"
variable "aws_secret_key = 7k7BcYF4aDTorCxp7q/3hOHomi0PEmH4wKR5boCj"
variable "aws_region = us-east-1"
variable "amis" {
    description = "AMIs by region"
    default = {
      us-east-1 = "ami-97785bed" # ubuntu 14.04 LTS
		  us-east-2 = "ami-f63b1193" # ubuntu 14.04 LTS
		  us-west-1 = "ami-824c4ee2" # ubuntu 14.04 LTS
		  us-west-2 = "ami-f2d3638a" # ubuntu 14.04 LTS
    }
}
vpc_cidr = "10.0.0.0/24"
public_subnet1_cidr = "10.0.1.0/24"
public_subnet2_cidr = "10.0.4.0/24"
public_subnet3_cidr = "10.0.3.0/24"
private_subnet_cidr = "10.0.2.0/24"
vpc_name = "visi-pro"
IGW_name = "visi-proigw"
public_subnet1_name = "visi-pro/Public"
public_subnet2_name = "visi-pro/Public"
public_subnet3_name = "visi-pro/Public"
private_subnet_name = "visi-pro/Private"
Main_Routing_Table = "visi-pro"
key_name = "visi-pro"
environment = "dev"
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
