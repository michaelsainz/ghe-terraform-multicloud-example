variable "name_tag_prefix" {
    description = "This represents the prefix used to append the name"
    type = "string"
}

variable "key_name" {
    description = "This is the name of the key pair to use within AWS EC2"
    type = "string"
}

variable "ghe_mgmt_password" {
    description = "Management password for GHE"
    type = "string"
}

variable "ghe_version" {
    description = "Version of GHE AWS AMI to use"
    type = "string"
}

variable "subnet_id" {
    description = "The subnet ID to use"
    type = "string"
}

variable "ghe-sg-id" {
    description = "The AWS EC2 Security Group ID"
    type = "string"
}

variable "private_key_path" {
    description = "The local path to the private key file matching the AWS EC2 key pair"
}