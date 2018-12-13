data "aws_ami" "GHE" {
  owners = ["895557238572"]

  filter {
        name   = "name"
        values = ["GitHub Enterprise ${var.ghe_version}"]
    }
}

# Network Interface for the GHE instance
resource "aws_network_interface" "ghe-network-adapter" {
  subnet_id = "${var.subnet_id}"

  security_groups = [
    "${var.ghe-sg-id}",
  ]

  tags {
    Name = "${var.name_tag_prefix}-multicloud"
  }
}

# EC2 instance for GHE
resource "aws_instance" "ec2_ghe" {
  ami                  = "${data.aws_ami.GHE.image_id}"
  instance_type        = "m4.xlarge"
  key_name             = "${var.key_name}"

  network_interface {
    device_index          = 0
    network_interface_id  = "${aws_network_interface.ghe-network-adapter.id}"
    delete_on_termination = false
  }

  connection {
    user        = "admin"
    private_key = "${file(var.private_key_path)}"
  }

  ebs_block_device = {
    delete_on_termination = true
    device_name           = "/dev/sda2"
    iops                  = 4000
    volume_size           = 1024
    volume_type           = "gp2"
  }

  tags {
    Name = "${var.name_tag_prefix}-multicloud"
  }
}