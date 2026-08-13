output "master_private_ip" {
  value = azurerm_linux_virtual_machine.master.private_ip_address
}

output "master_public_ip" {
  value = azurerm_public_ip.master_pip.ip_address
}

output "worker_private_ips" {
  value = [for vm in azurerm_linux_virtual_machine.worker : vm.private_ip_address]
}
