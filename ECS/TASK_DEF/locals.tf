locals {
  network_mode = var.launch_type == "FARGATE" ? var.network_mode : null
  requires_compatibilities = var.launch_type == "FARGATE" ? [var.launch_type] : null
  
  cpu = var.launch_type == "FARGATE" ? tostring(var.cpu) : null
  memory = var.launch_type == "FARGATE" ? tostring(var.memory) : null

  container_cpu = var.launch_type == "EC2" ? var.cpu : null
  container_memory = var.launch_type == "EC2" ? var.memory : null
  
}

#effective_host_port = var.launch_type == "FARGATE" ? null : var.host_port