resource "aws_iam_instance_profile" "yuma" {
  name = var.iam_instance_profile_name
  role = var.iam_instance_profile_role_name
}

output "iam_instance_profile" {
  value = aws_iam_instance_profile.yuma.arn
}