# tf-mod-ec2-without-ebs-block-device
Module to create ec2 with only root device

## Input Variables:
* server_name - ec2 Instance name used as asset tag e.g. itsnwe000-uk-v1-dev-server 
* ami_id - ID of the Amazon Machine Image (AMI) to use
* count - Number of instances to create
* instance_type - Size/type of instance to create e.g. t2.micro
* key_name - name of the SSH key to use
* username - username of root/admin user
* private_key_path - path to the SSH key file

* vpc_id - ID of the VPC to create the instance in
* vpc_cidr_blocks - CIDR block of the VPC the instance will be created in
* sg_name - Name of the Security Group the instance will be placed in
* security_group_ids - ID of the Security Group the instance will be placed in
* subnet_id - Subnet to create the instance in
* associate_public_ip_address - true/false assign an individual public IP
* private_ip - Specify the private IP if not using DHCP
* use_dhcp - true/false enable DHCP ip assignment
* source_dest_check - Used for NAT or VPNs. Controls if traffic is routed to the instance when the destination address does not match the instance

* root_volume_size - Size of root volume in GB
* root_volume_type - type of root volume
* root_volume_delete_on_termination - true/false delete the root volume when instance is terminated
* encrypted - true/false encrypt the root volume

* disable_api_termination - true/false whether the instance can be terminated
* instance_initiated_shutdown_behavior - stop or terminate when instance is shut down
* user_data - Startup script to run on first boot
* iam_instance_profile - ec2 IAM profile to assign to the instance



### Tagging Variables
* project_id - Project Code
* project_name - Project Nanme
* environment - Dev, Prod etc
* component - application, web etc
* cpm_backup - account name and frequency of backup e.g. itsnwe000_daily 
* start - Automated startup time
* stop - Automated shutdown time
* patching_cycle - Maintenance window and OS type, see https://wiki.deloittecloud.co.uk/display/p000209/Patch+Management

### CMDB Tags
* host_name - The CMDB naming convention compliant hostname i.e. AWS000UK03001
* operating_system - Operating System the instance will run i.e. Ubuntu 16.04, RHEL 7.5, Windows Server 2016 etc
* location - Data Centre location i.e. eu-west-1
* clustered - TRUE/FALSE, is the instance part of a cluster
* in_dmz - TRUE/FALSE, is the instance in a DMZ
* creator - The name of the engineer creating the instance
* cmdb - true/false, should the instance be added to CMDB
* dns_domain - The domain the instance will be part of


## Usage: 

Include into your terrform files the following way:

```
module "ec2_instance" {
  source                               = "git::https://github.com/corighose/terra-modules/tf-mod-ec2-without-ebs-block-device"
  sg_name                              = "ec2_security_group"
  vpc_id                               = "vpc-abcdefgh"
  vpc_cidr_blocks                      = "172.20.10.0/26"
  ami_id                               = "ami-68e8ed11"
  count                                = "1"
  instance_type                        = "t2.micro"
  subnet_id                            = "172.20.10.0/28"
  key_name                             = "awspemkey-uk-v1"
  username                             = "administrator"
  private_key_path                     = "~/Documents/SSH_Keys/awspemkey1"
  root_volume_size                     = "30"
  root_volume_type                     = "gp2"
  server_name                          = "abaserver-v1-dev"
  root_volume_delete_on_termination    = "true"
  disable_api_termination              = "false"
  instance_initiated_shutdown_behavior = "stop"
  user_data                            = ""
  associate_public_ip_address          = "false"
  iam_instance_profile                 = ""
  source_dest_check                    = "false"
  security_group_ids                   = "${aws_security_group.ec2_security_group.id}"
  project_id                           = "IBL0001"
  project_name                         = "My_Project"
  environment                          = "dev"
  component                            = "application"
  use_dhcp                             = "false"
  private_ip                           = "172.20.10.2/28"
  patching_cycle                       = "tuesday3-ubuntu"
  host_name                            = "ABASERVER1"
  operating_system                     = "ubuntu"
  location                             = "eu-west-1"
  cluster                              = "FALSE"
  in_dmz                               = "FALSE"
  creator                              = "Collins Orighose"
  cmdb                                 = "true"
  dns_domain                           = ""
}
```

## Outputs:

* private_ips
* private_ips
* network_interface_id
