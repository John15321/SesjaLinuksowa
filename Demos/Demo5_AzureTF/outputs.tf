output "public_ip" {
  description = "Public IP address of the Flatcar VM"
  value       = azurerm_public_ip.demo.ip_address
}

output "ssh_command" {
  description = "SSH command to connect to the VM"
  value       = "ssh core@${azurerm_public_ip.demo.ip_address}"
}
