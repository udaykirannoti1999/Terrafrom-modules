#Create Application Load balancer

resource "aws_lb" "yuma" {
  name               = var.alb_name
  internal           = var.alb_internal_state
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = "${var.alb_security_groups}"
  subnets            = var.alb_subnets
  idle_timeout       = var.alb_idle_timeout
}

output "alb_name" {
  value = aws_lb.yuma.id
}