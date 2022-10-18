## ECS task execution role data
data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# ECS task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "var.ecs_task_execution_role"
  assume_role_policy = "data.aws_iam_policy_document.ecs_task_execution_role.json"
}

# ECS task execution role policy attachment
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = "aws_iam_role.ecs_task_execution_role.visi-pro"
  policy_arn = "arn:aws:iam::214712740451:policy/visi-pro"
}
