variable "service_discovery_name" {
}
variable "service_discovery_description" {
  type    = string
}
variable "service_discovery_ttl" {
  type    = number
  default = 60
}
variable "service_discovery_namespace_id" {
}
variable "enable_health_check_custom_config" {
  type    = bool
  default = false
}
variable "health_check_failure_threshold" {
  type    = number
  default = 1
}
