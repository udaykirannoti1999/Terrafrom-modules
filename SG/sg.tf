#Create Security Group
resource "aws_security_group" "yuma" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.sg_vpc_id
  tags = {
    Name = var.sg_name
  }
}

output "security_groups" {
    value = "${aws_security_group.yuma.id}"
}