resource "aws_autoscaling_group" "yuma" {
  name                = var.asg_grp_name
  vpc_zone_identifier = var.asg_vpc_zone_identifier
  desired_capacity    = var.asg_desired_capacity
  min_size            = var.asg_min_size
  max_size            = var.asg_max_size
  health_check_type   = "EC2"

  lifecycle {
    create_before_destroy = true
  }

  dynamic "launch_template" {
    for_each = var.asg_purchase_option == "ondemand" ? [1] : []
    content {
      name    = var.asg_launch_template_name
      version = "$Latest"
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = var.asg_purchase_option == "spot" ? [1] : []
    content {

      launch_template {

        launch_template_specification {
          launch_template_name = var.asg_launch_template_name
          version              = "$Latest"
        }

        # 50% Primary
        override {
          instance_type     = "c5.xlarge"
          weighted_capacity = "2"
        }

        # 25%
        override {
          instance_type     = "t3a.xlarge"
          weighted_capacity = "1"
        }

        # 25%
        override {
          instance_type     = "c5a.xlarge"
          weighted_capacity = "1"
        }
      }

      instances_distribution {
        on_demand_base_capacity                  = 0
        on_demand_percentage_above_base_capacity = 0
        spot_allocation_strategy                 = "capacity-optimized"
      }
    }
  }

  tag {
    key                 = "Name"
    value               = var.asg_grp_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.asg_tagname
    propagate_at_launch = true
  }
}

