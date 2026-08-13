variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "my_ip" {
  description = "My public IP for SSH access"
  type        = string
}

variable "ssh_key_path" {
  description = "Path to SSH private key"
  type        = string
}
