#Creates ALB Listeners 80

resource "aws_lb_listener" "yuma" {
  load_balancer_arn = var.http_lis_alb_name
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = var.attach_default_target_group
  }
}

output "alb_listener_http" {
  value = aws_lb_listener.yuma.id
}