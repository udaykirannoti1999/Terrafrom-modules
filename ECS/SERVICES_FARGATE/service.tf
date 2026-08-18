resource "aws_ecs_service" "yuma" {
  name            = var.ecs_service_name
  cluster         = var.ecs_cluster_arn
  task_definition = var.ecs_task_definition_arn
  desired_count   = var.ecs_desired_count
  launch_type     = var.ecs_launch_type

  load_balancer {
    target_group_arn = var.ecs_target_group_arn
    container_name   = var.ecs_container_name
    container_port   = var.ecs_container_port
  }

  network_configuration {
    security_groups  = var.ecs_security_groups
    subnets          = var.ecs_subnet_groups
    assign_public_ip = var.ecs_assign_public_ip
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