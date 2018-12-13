# This creates the VPC that we'll use to for our primary instance in AWS
resource "aws_vpc" "my_vpc" {
  cidr_block = "${var.network_address_space}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.name_tag_prefix}-2CLOUD-tf"
  }
}

# This creates the Internet Gateway which allows us to connect to the Internet from within our VPC
resource "aws_internet_gateway" "my_igw" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags {
    Name = "${var.name_tag_prefix}-2CLOUD-tf"
  }
}

# This creates the default routing table for our VPC and Internet Gateway
resource "aws_default_route_table" "default_routing" {
  default_route_table_id = "${aws_vpc.my_vpc.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.my_igw.id}"
  }

  tags {
    Name = "${var.name_tag_prefix}-2CLOUD-tf"
  }
}

# Subnets that our VPC contains
resource "aws_subnet" "my_subnet" {
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "172.16.0.0/16"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name_tag_prefix}-2CLOUD-tf"
  }
}

# Security group for the GHE instance
resource "aws_security_group" "2CLOUDS-ghe-instance" {
  name        = "${var.aws_sg_ghe_name}"
  vpc_id      = "${aws_vpc.my_vpc.id}"
  description = "This is a test of the TF solution"
  tags = {
    Name = "${var.aws_sg_ghe_name}"
  }

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
    from_port = 123
    to_port = 123
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
}

  ingress {
    from_port = 161
    to_port = 161
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 1194
    to_port = 1194
    protocol = "udp"
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
    from_port = 123
    to_port = 123
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port = 161
    to_port = 161
    protocol = "udp"
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
