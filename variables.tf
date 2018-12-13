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

variable "name_tag_prefix" {
	description = "String prefix that uniquely identifies resources as part of the multi cloud solution"
	default = "GHE2CLOUD"
}

variable "network_address_space" {
	description = "The CIDR/network address space for the VPC"
	default = "172.16.0.0/16"
}

variable "ghe_mgmt_password" {
    description = "Management password for GHE"
    type = "string"
	default = "ChangeMeNow123"
}

variable "ghe_version" {
    description = "Version of GHE AWS AMI to use"
    type = "string"
}

variable "key_name" {
    description = "This is the name of the key pair to use within AWS EC2"
    type = "string"
}
/*
variable "ghe-sg-id" {
    description = "The AWS EC2 Security Group ID"
    type = "string"
}
*/
variable "private_key_path" {
    description = "The local path to the private key file matching the AWS EC2 key pair"
}

variable "aws_sg_ghe_name" {
    description = "Security group for the GHE instance"
    type = "string"
    default = "GHE-Primary-SecurityGroup"
}