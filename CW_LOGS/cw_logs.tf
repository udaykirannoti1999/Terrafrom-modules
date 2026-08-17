resource "aws_cloudwatch_log_group" "yuma" {
  name              = var.cw_log_group_name
  retention_in_days = var.cw_retention_in_days
}

output "cw_log_group_name" {
  value = aws_cloudwatch_log_group.yuma.name 
}