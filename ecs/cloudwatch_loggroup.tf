# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "visi-proapp_log_group" {
  name              = "/ecs/visi-proapp"
  retention_in_days = 30

  tags = {
    Name = "cw-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "visi-proapp_log_stream" {
  name           = "visipro-log-stream"
  log_group_name = aws_cloudwatch_log_group.visiproapp_log_group.visipro
}

