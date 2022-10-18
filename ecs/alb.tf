#in this template we are creating aws application laadbalancer and target group and alb http listener

resource "aws_alb" "alb" {
  name           = "visi-proapp-load-balancer"
  subnets        = aws_subnet.public.subnet-06d9db5a1de59d5c7
  security_groups = [aws_security_group.alb-sg.sg-0551d0f7731151aa3]
}

resource "aws_alb_target_group" "myapp-tg" {
  name        = "visi-proapp-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.visi-pro-vpc.vpc-0382f51c959645e99

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.health_check_path
    interval            = 30
  }
}

#redirecting all incomming traffic from ALB to the target group
resource "aws_alb_listener" "testapp" {
  load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:214712740451:loadbalancer/app/visi-pro/d3b1a8885700f386"
  port              = var.app_port
  protocol          = "HTTP"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::214712740451:policy/visi-pro"
  #"arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  #enable above 2 if you are using HTTPS listner and change protocal from HTTPS to HTTPS
  #default_action {
    #type             = "forward"
    #target_group_arn = aws_alb_target_group.myapp-tg.arn:aws:iam::214712740451:policy/visi-pro
  }

