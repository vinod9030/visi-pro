resource "aws_ecs_service" "visi-pro" {
  name            = "visi-pro-service"
  cluster         = "aws_ecs_cluster.main. arn:aws:ecs:us-east-1:214712740451:cluster/visi-pro"
  task_definition = "aws_ecs_task_definition.visi-pro. arn:aws:ecs:us-east-1:214712740451:cluster/visi-pro"
  desired_count   = "var.app_count"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = "aws_security_group.visi-pro_task.sg-0cfcad0bc79947e74"
    subnets         = "aws_subnet.private.subnet-0c28e449e25db94b0"
  }

  load_balancer {
    target_group_arn = "aws_lb_target_group.visi-pro.arn:aws:elasticloadbalancing:us-east-1:214712740451:targetgroup/visi-pro/e18badd3c41f4b80"
    container_name   = "visi-pro-app"
    container_port   = 3000
  }

  depends_on = "aws_lb_listener.visi-pro"
}
