resource "aws_ecs_task_definition" "yuma" {
  family                   = var.task_definition_name
  network_mode             = local.network_mode
  requires_compatibilities = local.requires_compatibilities
  cpu                      = local.cpu
  memory                   = local.memory
  
  container_definitions = jsonencode([ 
    merge(
      {
        name      = "${var.task_definition_name}"
        image     = "${var.image_name}"
        essential = true
        portMappings = [
            {
              containerPort = "${var.container_port}"
              hostPort      = "${var.host_port}"
            }
        ]
      },
      local.container_cpu != null ? { cpu = local.container_cpu } : {},
      local.container_memory != null ? { memory = local.container_memory } : {}
    )
  ])

  dynamic "runtime_platform" {
    for_each = var.launch_type == "FARGATE" ? [1] : []
    content {
      operating_system_family = "LINUX"
      cpu_architecture        = "X86_64"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "task_definition" {
  value = aws_ecs_task_definition.yuma.arn
}