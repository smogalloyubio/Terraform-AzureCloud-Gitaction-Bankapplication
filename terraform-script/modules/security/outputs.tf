output "master_nsg_id" {
  description = "The ID of the Master Network Security Group"
  value       = azurerm_network_security_group.master_nsg.id
}

output "worker_nsg_id" {
  description = "The ID of the Worker Network Security Group"
  value       = azurerm_network_security_group.worker_nsg.id
}
