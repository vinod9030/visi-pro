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
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" terraform-aws-testing" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "${var.vpc_visi-pro}"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
	tags = {
        Name = "${var.IGW_terraform-aws-igw}"
    }
}

resource "aws_subnet" "subnet1-public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.public_subnet1_10.1.1.0/24}"
    availability_zone = "us-east-1a"

    tags = {
        Name = "${var.public_subnet1_Terraform_Public_Subnet1-testing}"
    }
}

resource "aws_subnet" "subnet2-public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.public_subnet2_10.1.1.0/24}"
    availability_zone = "us-east-1b"

    tags = {
        Name = "${var.public_subnet2_Terraform_Public_Subnet2-testing}"
    }
}

resource "aws_subnet" "subnet3-public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.public_subnet3_10.1.1.0/24}"
    availability_zone = "us-east-1c"

    tags = {
        Name = "${var.public_subnet3_Terraform_Public_Subnet3-testing}"
    }
	
}


resource "aws_route_table" "terraform-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "${var.Main_Routing_Table}"
    }
}

resource "aws_route_table_association" "terraform-public" {
    subnet_id = "${aws_subnet.subnet1-public.id}"
    route_table_id = "${aws_route_table.terraform-public.id}"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }
}

#data "aws_ami" "my_ami" {
#      most_recent      = true
#      #name_regex       = "vinod"
#      owners           = ["444984551434"]
#}


resource "aws_instance" "web-1" {
    #ami = "${data.aws_ami.my_ami.id}"
    ami = "ami-0d857ff0f5fc4e03b"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "LaptopKey"
    subnet_id = "${aws_subnet.subnet1-public.id}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true	
    tags = {
        Name = "Server-1"
        Env = "Prod"
        Owner = "vinod"
    }
}

#output "ami_id" {
#  value = "${data.aws_ami.my_ami.id}"
#}
