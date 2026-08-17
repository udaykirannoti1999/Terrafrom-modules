resource "aws_instance" "yuma" {
  ami                         = var.ec2_instance_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.ec2_subnet_id
  associate_public_ip_address = var.ec2_public_ip
  key_name                    = var.ec2_key_pair_name
  vpc_security_group_ids      = var.ec2_security_group_ids

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_size
    volume_type           = var.ec2_volume_type
  }
  tags = {
    Name = "${var.ec2_tag_name}"
  }
}
