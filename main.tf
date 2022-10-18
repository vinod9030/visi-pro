terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}



# Configure the AWS Provider
 

provider "aws" {
    access_key = "{APKATD7PANJR3GE2XQ2U}"
    secret_key = "{7k7BcYF4aDTorCxp7q/3hOHomi0PEmH4wKR5boCj}"
    region = "{us-east-1}"
}

resource "aws_vpc" "default" {
    cidr_block = "{10.0.0.0/16}"
    enable_dns_hostnames = true
    tags = {
        Name = "{visi-pro}"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "{vpc-0e4ba9e87082d56aa}"
	tags = {
        Name = "{visi-proigw}"
    }
}

resource "aws_subnet" "subnet1-public" {
    vpc_id = "{vpc-0e4ba9e87082d56aa}"
    cidr_block = "{10.0.1.0/24}"
    availability_zone = "us-east-1a"

    tags = {
        Name = "{public_subnet1_visi-pro/Public}"
    }
}

resource "aws_subnet" "subnet2-public" {
    vpc_id = "{vpc-0e4ba9e87082d56aa}"
    cidr_block = "{10.0.3.0/24}"
    availability_zone = "us-east-1b"

    tags = {
        Name = "{public_subnet2_visi-pro/Public}"
    }
}

resource "aws_subnet" "subnet3-public" {
    vpc_id = "{vpc-0e4ba9e87082d56aa}"
    cidr_block = "{10.0.4.0/24}"
    availability_zone = "us-east-1c"

    tags = {
        Name = "{public_subnet3_visi-pro/Public}"
    }
	
}


resource "aws_route_table" "terraform-public" {
    vpc_id = "{vpc-0e4ba9e87082d56aa}"

    route {
        cidr_block = "10.0.1.0/24"
        gateway_id = "{igw-0d60856dcdbe4bc5f}"
    }

    tags = {
        Name = "{Main_Routing_Table}"
    }
}

resource "aws_route_table_association" "terraform-public" {
    subnet_id = "{subnet-04ed3aeb3e95cdd42}"
    route_table_id = "{rtb-03a0af9d32807b10f}"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "{vpc-0e4ba9e87082d56aa}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/24"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["10.0.0.0/24"]
    }
}

#data "aws_ami" "my_ami" {
      #most_recent      = true
      #name_regex       = "vinod"
      #owners           = ["444984551434"]



resource "aws_instance" "web-1" {
    #ami = "${data.aws_ami.my_ami.id}"
    ami = "ami-0d857ff0f5fc4e03b"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "visi-pro"
    subnet_id = "{subnet-04ed3aeb3e95cdd42}"
    vpc_security_group_ids = ["{sg-0cfcad0bc79947e74}"]
    associate_public_ip_address = true	
    tags = {
        Name = "Server-1"
        Env = "Prod"
        Owner = "Sree"
    }
}

#output "ami_id" {
#  value = "${data.aws_ami.my_ami.id}"
#}
