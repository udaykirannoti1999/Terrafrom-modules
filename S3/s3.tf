resource "aws_s3_bucket" "yuma" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "${var.s3_bucket_name}"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "yuma" {
  bucket = aws_s3_bucket.yuma.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
    bucket_key_enabled = "true"
  }
}