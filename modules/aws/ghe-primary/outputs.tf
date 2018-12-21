output "ghe-primary-public-dns" {
    value = "${aws_instance.ec2_ghe.public_dns}"
}