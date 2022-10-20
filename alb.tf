resource "aws_lb" "default" {
  name            = "visi-pro-lb"
  subnets         = "subnet-04ed3aeb3e95cdd42"
  security_groups = "sg-0cfcad0bc79947e74"
}



resource "aws_lb_target_group" "hello_world" {
  name        = "example-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "vpc-0e4ba9e87082d56aa"
  target_type = "ip"
}



resource "aws_lb_listener" "hello_world" {
  load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:214712740451:loadbalancer/app/visi-pro/d3b1a8885700f386"
  port              = "80"
  protocol          = "HTTP"



 default_action {
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:214712740451:targetgroup/visi-pro/e18badd3c41f4b80"
    type             = "forward"
  }
}
