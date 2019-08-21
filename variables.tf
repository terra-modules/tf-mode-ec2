variable "sg_name" {}
variable "vpc_id" {}
variable "vpc_cidr_blocks" {}
variable "ami_id" {}
variable "count" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "key_name" {}
variable "username" {}
variable "private_key_path" {}
variable "root_volume_size" {}
variable "root_volume_type" {}
variable "root_volume_delete_on_termination" {}
variable "server_name" {}
variable "disable_api_termination" {}
variable "instance_initiated_shutdown_behavior" {}
variable "user_data" {}

variable "associate_public_ip_address" {}
variable "iam_instance_profile" {}
variable "source_dest_check" {}

variable "security_group_ids" {}
variable "project_id" {}
variable "project_name" {}
variable "environment" {}
variable "component" {}

variable "cpm_backup" {
  default = ""
}

variable "start" {
  default = ""
}

variable "stop" {
  default = ""
}

variable "p_start" {
  default = ""
}

variable "p_stop" {
  default = ""
}

variable "q_start" {
  default = ""
}

variable "q_stop" {
  default = ""
}

variable "private_ip" {
  default = ""
}

variable "use_dhcp" {
  default = true
}

variable "patching_cycle" {
  default = "nopatch"
}

variable "encrypted" {
  default = false
}

//CMDB Tags
variable "host_name" {
  default = ""
}

variable "operating_system" {
  default = ""
}

variable "location" {
  default = "eu-west-1"
}

variable "clustered" {
  default = false
}

variable "in_dmz" {
  default = false
}

variable "creator" {
  default = ""
}

variable "cmdb" {
  default = false
}

variable "dns_domain" {
  default = ""
}
