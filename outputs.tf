output "ghe-primary-dns-hostname" {
  value = "${module.ghe-primary.ghe-primary-public-dns}"
}
output "ghe-primary-mgmt-portal-url" {
  value = "https://${module.ghe-primary.ghe-primary-public-dns}:8443/setup/start"
}
