resource "aws_instance" "ec2" {
  ami           = "${var.ami_id}"
  count         = "${var.count}"
  instance_type = "${var.instance_type}"

  subnet_id                            = "${var.subnet_id}"
  key_name                             = "${var.key_name}"
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  user_data                            = "${var.user_data}"
  vpc_security_group_ids               = ["${var.security_group_ids}"]
  associate_public_ip_address          = "${var.associate_public_ip_address}"
  iam_instance_profile                 = "${var.iam_instance_profile}"
  source_dest_check                    = "${var.source_dest_check}"
  private_ip                           = "${var.use_dhcp ? "" : var.private_ip}"

  connection {
    user        = "${var.username}"
    private_key = "${file(var.private_key_path)}"
  }

  root_block_device = [
    {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_volume_delete_on_termination}"

      //encrypted             = "${var.encrypted}"
    },
  ]

  lifecycle {
    create_before_destroy = true
    ignore_changes = ["ebs_optimized", "user_data"]
  }

  tags {
    Name           = "${var.server_name}-${count.index + 1}"
    created_by     = "terraform"
    project_id     = "${var.project_id}"
    project_name   = "${var.project_name}"
    environment    = "${var.environment}"
    component      = "${var.component}"
    "cpm backup"   = "${var.cpm_backup}"
    "auto:start"   = "${var.start}"
    "auto:stop"    = "${var.stop}"
    "p_auto:start" = "${var.p_start}"
    "p_auto:stop"  = "${var.p_stop}"
    "q_auto:start" = "${var.q_start}"
    "q_auto:stop"  = "${var.q_stop}"
    "Patch Group"  = "${var.patching_cycle}"
    host_name      = "${var.host_name}"
    os             = "${var.operating_system}"
    location       = "${var.location}"
    cluster        = "${var.clustered}"
    dmz            = "${var.in_dmz}"
    owner          = "${var.creator}"
    cmdb           = "${var.cmdb}"
    domain         = "${var.dns_domain}"
  }

  volume_tags {
    Name = "${var.server_name}-${count.index + 1}"
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2" {
  count               = "${var.count}"
  alarm_name          = "autorecover-${aws_instance.ec2.id}"
  namespace           = "AWS/EC2"
  evaluation_periods  = "2"
  period              = "60"
  alarm_description   = "This metric auto recovers EC2 instances"
  alarm_actions       = ["arn:aws:automate:${var.location}:ec2:recover"]
  statistic           = "Minimum"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "1"
  metric_name         = "StatusCheckFailed_System"

  dimensions {
    InstanceId = "${aws_instance.ec2.id}"
  }
}
