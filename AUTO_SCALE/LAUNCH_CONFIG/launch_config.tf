resource "aws_launch_configuration" "yuma" {
  name_prefix                 = var.asg_launch_config_name
  image_id                    = var.asg_ami_name
  instance_type               = var.asg_instance_type
  iam_instance_profile        = var.asg_iam_profile_arn
  key_name                    = var.asg_key_pair
  user_data                   = var.asg_user_data
  security_groups             = var.asg_security_groups
  associate_public_ip_address = var.asg_public_ip_address
  enable_monitoring           = var.asg_enable_monitoring
  ebs_optimized               = "true"
  lifecycle {
    create_before_destroy = true
  }
  root_block_device {
    volume_type = var.asg_volume_type
    volume_size = var.asg_volume_size
  }
}

output "launch_configuration_name" {
  value = aws_launch_configuration.yuma.name
}