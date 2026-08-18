#Create Security Group

resource "aws_security_group_rule" "yuma" {
  type                     = var.sg_ruletype
  from_port                = var.sg_from_port
  to_port                  = var.sg_to_port
  protocol                 = var.sg_protocoltype
  source_security_group_id = var.sg_source_group_id
  security_group_id        = var.sg_group_id
}
