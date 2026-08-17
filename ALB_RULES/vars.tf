variable "listener_arn" {
}
variable "rule_priority" {
}
variable "rule_target_group_arn" {
}
variable "conditions" {
  description = "List of conditions for the rule"
  type = list(object({
    path_pattern  = optional(list(string))
    host_header   = optional(list(string))
  }))
}
