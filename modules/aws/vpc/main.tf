# This creates the VPC that we'll use to for our primary instance in AWS
resource "aws_vpc" "my_vpc" {
  cidr_block = "${var.network_address_space}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.name_tag_prefix}-ghedemo-tf"
  }
}

# This creates the Internet Gateway which allows us to connect to the Internet from within our VPC
resource "aws_internet_gateway" "my_igw" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags {
    Name = "${var.name_tag_prefix}-ghedemo-tf"
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
    Name = "${var.name_tag_prefix}-ghedemo-tf"
  }
}

# Subnets that our VPC contains
resource "aws_subnet" "my_subnet" {
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "172.16.0.0/16"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name_tag_prefix}-ghedemo-tf"
  }
}