resource "aws_iam_role" "yuma" {
  assume_role_policy = var.iam_assume_role_policy
  name               = var.iam_role_name
}

output "iam_role_name" {
  value = aws_iam_role.yuma.name
}