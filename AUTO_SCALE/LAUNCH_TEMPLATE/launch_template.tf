resource "aws_launch_template" "yuma" {
  name_prefix                 = var.asg_launch_template_name
  image_id                    = var.asg_ami_name
  instance_type               = var.asg_instance_type
  key_name                    = var.asg_key_pair
  user_data                   = var.asg_user_data
  ebs_optimized               = "true"
  
  lifecycle {
    create_before_destroy = true
  }
  
  iam_instance_profile {
    arn = var.asg_iam_profile_arn
  }

  network_interfaces {
    security_groups             = var.asg_security_groups
    associate_public_ip_address = var.asg_public_ip_address
  }

  monitoring {
    enabled = var.asg_enable_monitoring
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      encrypted   = true
      volume_type = var.asg_volume_type
      volume_size = var.asg_volume_size
    }
  }
}

output "launch_template_name" {
  value = aws_launch_template.yuma.name
}