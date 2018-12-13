/*
terraform {
  required_version = ">= 0.10, < 0.12"

  backend "s3" {
    encrypt = true
    bucket = "msainz-tf-state"
    dynamodb_table = "terraform-state-lock-dynamo"
    region = "us-west-1"
    key = "terraform.tfstate"
  }
}
*/

provider "aws" {
  region     = "${var.aws_region}"
  profile    = "${var.aws_provider_profile}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

module "vpc" {
  source = "./modules/aws/vpc"

  name_tag_prefix = "${var.name_tag_prefix}"
  network_address_space = "${var.network_address_space}"
  aws_sg_ghe_name = "${var.aws_sg_ghe_name}"
}


module "ghe-instance" {
  source = "./modules/aws/ghe-instance"

  ghe_mgmt_password = "${var.ghe_mgmt_password}"
  ghe_version = "${var.ghe_version}"
  name_tag_prefix = "${var.name_tag_prefix}"
  key_name = "${var.key_name}"
  subnet_id = "${module.vpc.subnet_id}"
  ghe-sg-id = "${module.vpc.ghe-sg-id}"
  private_key_path = "${var.private_key_path}"
}

/*
module "iam-roles-policies" {
  source = "./modules/aws/iam"

  aws_sg_ghe_name = "${var.aws_sg_ghe_name}"
  aws_vpc_id = "${module.vpc.vpc_id}"
}
*/