variable "name_tag_prefix" {
    description = "String prefix that uniquely identifies resources as part of the multi cloud solution"
    default = "GHE2CLOUD"
}
variable "network_address_space" {
    description = "The CIDR/network address space for the VPC"
    default = "172.16.0.0/16"
}