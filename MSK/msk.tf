resource "aws_msk_cluster" "yuma" {
  cluster_name           = var.msk_cluster_name
  kafka_version          = var.msk_cluster_version
  number_of_broker_nodes = var.msk_broker_count

  broker_node_group_info {
    instance_type  = var.msk_instance_type
    client_subnets = var.msk_client_subnets
    storage_info {
      ebs_storage_info {
        volume_size = var.msk_volume_size
      }
    }
    security_groups = var.msk_security_groups
  }
  
  lifecycle {
    ignore_changes = [
      broker_node_group_info[0].storage_info[0].ebs_storage_info
    ]
  }

  client_authentication {
    unauthenticated = var.msk_plain_authentication
    sasl {
      iam = var.msk_iam_authentication 
    }
  }
  
  configuration_info {
    arn      = var.msk_configuration_arn
    revision = var.msk_configuration_latest_revision
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS_PLAINTEXT"
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = var.msk_cw_name
      }
    }
  }

  tags = {
    Name = var.msk_cluster_name
  }
}