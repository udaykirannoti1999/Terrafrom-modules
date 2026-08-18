variable "ecs_service_name" {
}
variable "ecs_cluster_arn" {
}
variable "ecs_task_definition_arn" {
}
variable "ecs_desired_count" {
}
variable "ecs_container_name" {
}
variable "ecs_container_port" {
}
variable "ecs_target_group_arn" {
}
variable "ecs_launch_type" {
}
variable "ecs_assign_public_ip" {
}
variable "ecs_subnet_groups" {
}
variable "ecs_security_groups" {
}
variable "ecs_service_registry_arn" {  
}
variable "ecs_enable_alb" {
  type  = bool
}
variable "ecs_enable_service_discovery" {
  type  = bool
}
variable "ecs_health_check_grace_period" {
  type        = number
  default     = null
}