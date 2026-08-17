resource "aws_service_discovery_service" "yuma" {
  name        = var.service_discovery_name
  description = var.service_discovery_description

  dns_config {
    namespace_id = var.service_discovery_namespace_id

    dns_records {
      ttl  = var.service_discovery_ttl
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  dynamic "health_check_custom_config" {
    for_each = var.enable_health_check_custom_config ? [1] : []
    content {
      failure_threshold = var.health_check_failure_threshold
    }
  }
}