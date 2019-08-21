output "private_ips" {
  value = "${aws_instance.ec2.*.private_ip}"
}

output "instance_ids" {
  value = "${aws_instance.ec2.*.id}"
}

output "network_interface_id" {
  value = "${aws_instance.ec2.*.network_interface_id}"
}
