# security group creation and attcahing in ecs, alb etc

# ALB Security Group: Edit to restrict access to the application
resource "aws_security_group" "visi-pro" {
  name        = "visi-proapp-load-balancer-security-group"
  description = "controls access to the ALB"
  vpc_id      = "aws_vpc.visi-pro-vpc.vpc-0382f51c959645e99"

  ingress {
    protocol    = "tcp"
    from_port   = "var.app_port"
    to_port     = "var.app_port"
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["172.31.0.0/16"]
  }
}

# this security group for ecs - Traffic to the ECS cluster should only come from the ALB
resource "aws_security_group" "visi-pro" {
  name        = "visi-proapp-ecs-tasks-security-group"
  description = "allow inbound access from the ALB only"
  vpc_id      ="aws_vpc.visi-pro-vpc.vpc-0382f51c959645e99"

  ingress {
    protocol        = "tcp"
    from_port       = "var.app_port"
    to_port         = "var.app_port"
    security_groups = "[aws_security_group.alb-sg.sg-0551d0f7731151aa3]"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["172.31.0.0/16"]
  }
}
