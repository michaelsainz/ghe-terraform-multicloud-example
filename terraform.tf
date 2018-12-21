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

module "ghe-primary" {
    source = "./modules/aws/ghe-primary"

    name_tag_prefix = "${var.name_tag_prefix}-primary-ghe"
    aws_access_key = "${var.aws_access_key}"
    aws_secret_key = "${var.aws_secret_key}"
    ghe_version = "${var.ghe_version}"
    aws_region = "${var.aws_region}"
    aws_az = "${var.aws_az}"
    aws_instance_type = "${var.aws_instance_type}"
    ec2_key_name = "${var.ec2_key_name}"
}