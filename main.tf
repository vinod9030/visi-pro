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
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "${var.vpc_visi-pro}"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.vpc-0e4ba9e87082d56aa}"
	tags = {
        Name = "${var.IGW_visi-pro-igw}"
    }
}

resource "aws_subnet" "subnet1-public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.public_subnet1_cidr}"
    availability_zone = "us-east-1a"

    tags = {
        Name = "${var.public_subnet1_name}"
    }
}

resource "aws_subnet" "subnet2-public" {
    vpc_id = "${aws_vpc.default.vpc-0e4ba9e87082d56aa}"
    cidr_block = "${var.public_subnet2_cidr}"
    availability_zone = "us-east-1b"

    tags = {
        Name = "${var.public_subnet2_visi-pro/Public}"
    }
}

resource "aws_subnet" "subnet3-public" {
    vpc_id = "${aws_vpc.default.vpc-0e4ba9e87082d56aa}"
    cidr_block = "${var.public_subnet3_cidr}"
    availability_zone = "us-east-1c"

    tags = {
        Name = "${var.public_subnet3_visi-pro/Public}"
    }
	
}


resource "aws_route_table" "terraform-public" {
    vpc_id = "${aws_vpc.default.vpc-0e4ba9e87082d56aa}"

    route {
        cidr_block = "10.0.0.0/16"
        gateway_id = "${aws_internet_gateway.default.igw-0d60856dcdbe4bc5f}"
    }

    tags = {
        Name = "${var.Main_Routing_Table}"
    }
}

resource "aws_route_table_association" "terraform-public" {
    subnet_id = "${aws_subnet.subnet1-public.subnet-04ed3aeb3e95cdd42}"
    route_table_id = "${aws_route_table.terraform-public.rtb-03a0af9d32807b10f}"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.default.vpc-0e4ba9e87082d56aa}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["10.0.0.0/16"]
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
    subnet_id = "${aws_subnet.subnet1-public.subnet-04ed3aeb3e95cdd42}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.sg-0cfcad0bc79947e74}"]
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
