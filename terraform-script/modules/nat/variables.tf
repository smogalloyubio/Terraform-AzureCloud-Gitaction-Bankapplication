variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "worker_subnet_id" {
  description = "The ID of the worker subnet"
  type        = string
}

variable "tags" {
  description = "Tags to apply to NAT resources"
  type        = map(string)
  default     = {}
}
