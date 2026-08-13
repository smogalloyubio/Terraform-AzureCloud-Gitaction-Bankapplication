variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "vnet_cidr" {
  description = "The CIDR block for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "master_subnet_prefix" {
  description = "The subnet prefix for the master node"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "worker_subnet_prefix" {
  description = "The subnet prefix for the worker nodes"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "nat_subnet_prefix" {
  description = "The subnet prefix for the NAT gateway"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "tags" {
  description = "Tags to apply to network resources"
  type        = map(string)
  default     = {}
}
