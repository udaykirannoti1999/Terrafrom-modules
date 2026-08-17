resource "aws_efs_file_system" "yuma" {
  creation_token   = var.efs_name
  encrypted        = "true"
  performance_mode = "generalPurpose"

  tags = {
    Name = "${var.efs_name}"
  }
}
resource "aws_efs_backup_policy" "yuma_efs_backup" {
  file_system_id = aws_efs_file_system.yuma.id

  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "yuma_efs_mount" {
  count           = 3
  file_system_id  = aws_efs_file_system.yuma.id
  subnet_id       = element(var.efs_subnet_id, count.index)
  security_groups = var.efs_security_groups
}
