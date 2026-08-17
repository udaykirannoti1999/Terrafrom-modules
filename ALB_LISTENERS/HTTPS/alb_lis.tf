#Creates ALB Listeners 443
resource "aws_lb_listener" "yuma" {
  load_balancer_arn = var.https_lis_alb_name
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_arn

  default_action {
    type             = "forward"
    target_group_arn = var.attach_default_target_group
  }
}

output "alb_listener_https" {
  value = aws_lb_listener.yuma.id
}
