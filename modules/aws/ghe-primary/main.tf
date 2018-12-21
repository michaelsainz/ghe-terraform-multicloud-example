provider "aws" {
  region     = "${var.aws_region}"
  profile    = "${var.aws_provider_profile}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

data "aws_ami" "ghe-instance" {
    owners = ["895557238572"]
    filter {
        name   = "name"
        values = ["GitHub Enterprise ${var.ghe_version}"]
    }
}

# Network Interface for the GHE instance
resource "aws_network_interface" "ghe-network-adapter" {
  subnet_id = "${aws_subnet.ghe_primary_subnet.id}"

  security_groups = [
    "${aws_security_group.2CLOUDS-ghe-instance.id}",
  ]

  tags {
    Name = "${var.name_tag_prefix}-ghedemo-tf"
  }
}

resource "aws_instance" "ec2_ghe" {
  ami                  = "${data.aws_ami.ghe-instance.image_id}"
  instance_type        = "${var.aws_instance_type}"
  key_name             = "${var.ec2_key_name}"
  user_data = "${data.template_file.script.template}"

  network_interface {
    device_index          = 0
    network_interface_id  = "${aws_network_interface.ghe-network-adapter.id}"
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
    Name = "${var.name_tag_prefix}-ghedemo-tf"
  }
}

data "template_file" "script" {
  template = "${file("${path.module}/../scripts/ghe-primary-config.sh")}"
}

module "aws_vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "1.49.0"
    tags = {
        Terraform = "true"
        Environment = "dev"
        Name = "${var.name_tag_prefix}-2CLOUD-tf"
    }

    cidr = "${var.network_address_space}"
    enable_dns_hostnames = true
}

resource "aws_subnet" "ghe_primary_subnet" {
  vpc_id                  = "${module.aws_vpc.vpc_id}"
  cidr_block              = "${var.network_address_space}"
  availability_zone       = "${var.aws_az}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name_tag_prefix}-ghedemo-tf"
  }
}

resource "aws_default_route_table" "default_routing" {
    default_route_table_id = "${module.aws_vpc.default_route_table_id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.my_igw.id}"
    }

    tags {
        Name = "${var.name_tag_prefix}-2CLOUD-tf"
    }
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = "${module.aws_vpc.vpc_id}"

    tags {
        Name = "${var.name_tag_prefix}-2CLOUD-tf"
    }
}

# Security group for the GHE instance
resource "aws_security_group" "2CLOUDS-ghe-instance" {
  name        = "${var.name_tag_prefix}-GHE-SG"
  vpc_id      = "${module.aws_vpc.vpc_id}"
  description = "This is a test of the 2CLOUDS TF solution"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 122
    to_port     = 122
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9418
    to_port     = 9418
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 122
    to_port     = 122
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 9418
    to_port     = 9418
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}