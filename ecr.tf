resource "aws_ecr_repository" "repository" {
  name                 = local.container-registry-name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}