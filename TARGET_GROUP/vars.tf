#Variables for ALB Target Group
variable "target_group_name" {}

variable "target_group_vpc_id" {}

variable "target_deregistration_delay" {}

variable "target_port" {}

variable "target_type" {
  description = "Type of targets (instance, ip, lambda)"
  type        = string
  
  validation {
    condition     = contains(["instance", "ip", "lambda"], var.target_type)
    error_message = "Target type must be one of: instance, ip, lambda."
  }
}

variable "health_check" {
  description = "Health check configuration"
  type = object({
    path                = optional(string, "/")
    timeout             = optional(number, 10)
    interval            = optional(number, 20)
    healthy_threshold   = optional(number, 2)
    unhealthy_threshold = optional(number, 2)
  })
}