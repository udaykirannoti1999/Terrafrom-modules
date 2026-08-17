variable "emr_name" {
}
variable "emr_release_label" {
}
variable "emr_applications" {
    type = list
}
variable "emr_key_name" {
}
variable "emr_subnet_id" {
}
variable "emr_master_security_group" {
}
variable "emr_slave_security_group" {
}
variable "emr_instance_profile" {
}
variable "emr_s3_log_uri" {
}
variable "emr_ebs_root_volume_size" {
}
variable "emr_master_instance_type" {
}
variable "emr_master_instance_count" {
}
variable "emr_master_ebs_size" {
}
variable "emr_master_ebs_type" {
}
variable "emr_master_ebs_volume_count" {
}
variable "emr_core_instance_type" {
}
variable "emr_core_instance_count" {
}
variable "emr_core_ebs_size" {
}
variable "emr_core_ebs_type" {
}
variable "emr_core_ebs_volume_count" {
}
variable "emr_service_role" {
}
variable "emr_minimum_capacity_units" {
}
variable "emr_maximum_capacity_units" {
}
variable "emr_maximum_ondemand_capacity_units" {
}
variable "emr_maximum_core_capacity_units" {
}