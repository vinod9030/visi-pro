
resource "aws_ecs_task_definition" "visi-pro" {
  family                   = "visi-pro-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  container_definitions = <<DEFINITION
[
  {
    "image": "heroku/nodejs-visi-pro",
    "cpu": 1024,
    "memory": 2048,
    "name": "visi-pro-app",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ]
  }
]
DEFINITION
}

resource "aws_security_group" "visi-pro_task" {
  name        = "visi-pro-task-security-group"
  vpc_id      = "vpc-0e4ba9e87082d56aa"

  ingress {
    protocol        = "tcp"
    from_port       = 3000
    to_port         = 3000
    security_groups = "sg-0cfcad0bc79947e74"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["10.0.0.0/16"]
  }
}

