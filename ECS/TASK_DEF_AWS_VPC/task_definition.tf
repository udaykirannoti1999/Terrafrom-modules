resource "aws_ecs_task_definition" "yuma" {
  family = var.task_definition_name
  network_mode = var.network_mode
  container_definitions = jsonencode([
    {
      name      = "${var.task_definition_name}"
      image     = "${var.image_name}"
      cpu       = "${var.cpu}"
      memory    = "${var.memory}"
      essential = true
      portMappings = [
        {
          containerPort = "${var.container_port}"
          hostPort      = "${var.host_port}"
        }
      ]
    }
  ])
}

output "task_definition" {
  value = aws_ecs_task_definition.yuma.arn
}