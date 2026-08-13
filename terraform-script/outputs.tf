output "master_public_ip" {
  value = module.compute.master_public_ip
}

output "application_public_url" {
  value = "http://${module.compute.master_public_ip}"
}
