resource "aws_emr_cluster" "yuma" {
  name                              = var.emr_name
  release_label                     = var.emr_release_label
  applications                      = var.emr_applications
  termination_protection            = true
  keep_job_flow_alive_when_no_steps = true

  ec2_attributes {
    key_name                          = var.emr_key_name
    subnet_id                         = var.emr_subnet_id
    emr_managed_master_security_group = var.emr_master_security_group
    emr_managed_slave_security_group  = var.emr_slave_security_group
    instance_profile                  = var.emr_instance_profile
  }

  configurations = data.template_file.yuma.rendered
  ebs_root_volume_size = var.emr_ebs_root_volume_size

  master_instance_group {
    instance_type = var.emr_master_instance_type
    instance_count = var.emr_master_instance_count
    ebs_config {
        size                 = var.emr_master_ebs_size
        type                 = var.emr_master_ebs_type
        volumes_per_instance = var.emr_master_ebs_volume_count
    }
  }

  core_instance_group {
    instance_type  = var.emr_core_instance_type
    instance_count = var.emr_core_instance_count
    ebs_config {
        size                 = var.emr_core_ebs_size
        type                 = var.emr_core_ebs_type
        volumes_per_instance = var.emr_core_ebs_volume_count
    }
  }

  service_role = var.emr_service_role
}

resource "aws_emr_managed_scaling_policy" "yuma" {
  cluster_id = aws_emr_cluster.yuma.id
  compute_limits {
    unit_type                       = "Instances"
    minimum_capacity_units          = var.emr_minimum_capacity_units
    maximum_capacity_units          = var.emr_maximum_capacity_units
    maximum_ondemand_capacity_units = var.emr_maximum_ondemand_capacity_units
    maximum_core_capacity_units     = var.emr_maximum_core_capacity_units
  }
}