variable "name_suffix" {
  description = "Unique suffix for resource names (e.g. your initials)"
  default     = "jb"
}

variable "location" {
  description = "Azure region"
  default     = "westeurope"
}

variable "vm_name" {
  description = "Name of the Flatcar VM"
  default     = "flatcar-tofu-demo-vm"
}

variable "vm_size" {
  description = "Azure VM size"
  default     = "Standard_B2s"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  default     = "~/.ssh/id_ed25519.pub"
}
