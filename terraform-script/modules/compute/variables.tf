variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "master_subnet_id" {
  description = "The ID of the master subnet"
  type        = string
}

variable "worker_subnet_id" {
  description = "The ID of the worker subnet"
  type        = string
}

variable "master_private_ip" {
  description = "Private IP of the master node"
  type        = string
}

variable "master_public_ip" {
  description = "Public IP of the master node"
  type        = string
}

variable "k3s_token" {
  description = "The K3s cluster token"
  type        = string
  sensitive   = true
}

variable "admin_username" {
  description = "The admin username for the VMs"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VMs"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to compute resources"
  type        = map(string)
  default     = {}
}
