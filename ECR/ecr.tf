resource "aws_ecr_repository" "yuma" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

output "ecr_repo_name" {
  value = aws_ecr_repository.yuma.name
}