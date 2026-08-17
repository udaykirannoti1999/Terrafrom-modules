resource "aws_autoscaling_group" "yuma" {
  name                 = var.asg_grp_name
  vpc_zone_identifier  = var.asg_vpc_zone_identifier
  desired_capacity     = var.asg_desired_capacity
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size
  health_check_type    = "EC2"
  lifecycle {
    create_before_destroy = true
  }
  
  launch_template {
    name      = var.asg_launch_template_name
    version   = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.asg_grp_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = var.asg_tagname
    propagate_at_launch = true
  }
}