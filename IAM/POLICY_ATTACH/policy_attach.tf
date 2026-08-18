resource "aws_iam_role_policy_attachment" "yuma" {
  role       = var.iam_role_arn
  policy_arn = var.iam_policy_arn
}

output "iam_role_policy_attachment" {
  value = aws_iam_role_policy_attachment.yuma.id
}