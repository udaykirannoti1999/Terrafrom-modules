resource "aws_ecs_cluster" "yuma" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = var.ecs_container_insights
  }
}

output "ecs_cluster_id" {
    value = "${aws_ecs_cluster.yuma.id}"
}