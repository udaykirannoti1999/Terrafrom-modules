resource "aws_acm_certificate" "yuma_acm" {
  domain_name               = "${var.acm_domainname}"
  subject_alternative_names = "${var.acm_sub_domainname}"
  validation_method         = "DNS"

  tags = {
    Name = "${var.acm_domainname}"
  }
}

output "acm_certificate_arn" {
  value = "${aws_acm_certificate.yuma_acm.arn}"
}