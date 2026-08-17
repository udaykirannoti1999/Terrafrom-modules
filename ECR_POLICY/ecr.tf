resource "aws_ecr_lifecycle_policy" "yuma" {
  repository = var.ecr_repo_name
  policy     = var.ecr_repo_policy
}
