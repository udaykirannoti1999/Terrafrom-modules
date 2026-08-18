resource "aws_lb_target_group" "yuma" {
  name                 = var.target_group_name
  port                 = var.target_port
  protocol             = "HTTP"
  vpc_id               = var.target_group_vpc_id
  target_type          = var.target_type
  deregistration_delay = var.target_deregistration_delay

  health_check {
    path                = var.health_check.path
    protocol            = "HTTP"
    interval            = var.health_check.interval
    timeout             = var.health_check.timeout
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }
}

output "aws_lb_target_group" {
  value = aws_lb_target_group.yuma.arn
}
