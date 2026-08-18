resource "aws_ecs_service" "yuma" {
  name            = var.ecs_service_name
  cluster         = var.ecs_cluster_arn
  task_definition = var.ecs_task_definition_arn
  desired_count   = var.ecs_desired_count
  launch_type     = var.ecs_launch_type

  # Health check grace period - Only set when explicitly provided
  health_check_grace_period_seconds = var.ecs_health_check_grace_period != null ? var.ecs_health_check_grace_period : null

  # Network configuration - Required for Fargate, optional for EC2 with awsvpc
  dynamic "network_configuration" {
    for_each = (var.ecs_launch_type == "FARGATE" || var.ecs_enable_service_discovery) ? [1] : []
    content {
      subnets          = var.ecs_subnet_groups
      security_groups  = var.ecs_security_groups
      assign_public_ip = var.ecs_assign_public_ip
    }
  }

  # Load balancer configuration - Conditional based on enable_alb
  dynamic "load_balancer" {
    for_each = var.ecs_enable_alb ? [1] : []
    content {
      target_group_arn = var.ecs_target_group_arn
      container_name   = var.ecs_container_name
      container_port   = var.ecs_container_port
    }
  }

  # Service discovery configuration - Conditional based on enable_service_discovery
  dynamic "service_registries" {
    for_each = var.ecs_enable_service_discovery ? [1] : []
    content {
      registry_arn   = var.ecs_service_registry_arn
      container_name = var.ecs_container_name
    }
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition
    ]
  }
}

output "ecs_service" {
  value =  aws_ecs_service.yuma.id 
}
