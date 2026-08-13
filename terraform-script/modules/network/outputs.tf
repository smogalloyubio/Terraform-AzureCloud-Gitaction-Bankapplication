output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "master_subnet_id" {
  description = "The ID of the Master subnet"
  value       = azurerm_subnet.master.id
}

output "worker_subnet_id" {
  description = "The ID of the Worker subnet"
  value       = azurerm_subnet.worker.id
}

output "nat_subnet_id" {
  description = "The ID of the NAT subnet"
  value       = azurerm_subnet.nat.id
}

output "master_public_ip" {
  description = "The allocated Master Public IP"
  value       = azurerm_public_ip.master_pip.ip_address
}

output "master_public_ip_id" {
  description = "The allocated Master Public IP ID"
  value       = azurerm_public_ip.master_pip.id
}
