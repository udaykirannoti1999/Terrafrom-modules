resource "aws_ecs_task_definition" "yuma" {
  family = var.task_definition_name
  network_mode = var.network_mode
  requires_compatibilities = ["FARGATE"]
  cpu       = "${var.cpu}"
  memory    = "${var.memory}"
  container_definitions = jsonencode([
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
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

output "task_definition" {
  value = aws_ecs_task_definition.yuma.arn
}