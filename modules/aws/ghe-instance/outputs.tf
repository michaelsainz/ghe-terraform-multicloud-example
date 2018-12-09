output "ghe-public-dns_root" {
  value = "${aws_instance.ec2_ghe.public_dns}"
}