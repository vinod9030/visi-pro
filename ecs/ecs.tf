resource "aws_ecs_cluster" "test-cluster" {
  name = "visi-proapp-cluster"
}

data "template_file" "testapp" {
  template = file("./templates/image/image.json")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "visi-pro-def" {
  family                   = "visi-proapp-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.testapp.rendered
}

resource "aws_ecs_service" "visi-pro-service" {
  name            = "visi-proapp-service"
  cluster         = aws_ecs_cluster.visi-pro-cluster.id
  task_definition = aws_ecs_task_definition.visi-pro-def.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = aws_subnet.private.subnet-04ed3aeb3e95cdd42
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.myapp-tg.arn
    container_name   = "visi-proapp"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.visi-proapp, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
