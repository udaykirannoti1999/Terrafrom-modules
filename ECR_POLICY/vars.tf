variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "ecr_repo_policy" {
  description = "The policy JSON for the ECR repository"
  type        = string
}
