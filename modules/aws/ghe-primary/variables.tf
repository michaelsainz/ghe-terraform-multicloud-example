variable "aws_provider_profile" {
	description = "Local profile to use in the AWS CLI tool"
	default = "default"
}

variable "aws_region" {
	description = "The AWS region that the resources will reside in"
	default = "us-west-1"
}

variable "aws_access_key" {
	description = "The AWS IAM User Access key that Terraform and AWS CLI will use to interact with the cloud endpoints"
}

variable "aws_secret_key" {
	description = "The AWS IAM User Secret key that Terraform and AWS CLI will use to interact with the cloud endpoints"
}

variable "ghe_version" {
    description = "Version of GHE AWS AMI to use"
    type = "string"
}

variable "network_address_space" {
	description = "The CIDR/network address space for the VPC"
	default = "172.16.0.0/16"
}

variable "name_tag_prefix" {
	description = "String prefix that uniquely identifies resources as part of the multi cloud solution"
	default = "GHE2CLOUD"
}

variable "aws_instance_type" {
	description = "The EC2 instance type that the primary GHE instance will run on"
}

variable "aws_az" {
    description = "The AWS availability zone for resources to be configured in"
    type = "string"
    default = "us-west-1a"
}

variable "ec2_key_name" {
    description = "This is the name of the key pair to use within AWS EC2"
    type = "string"
}