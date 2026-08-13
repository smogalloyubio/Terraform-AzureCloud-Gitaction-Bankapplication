variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "my_ip" {
  description = "Public IP address allowed to SSH to the master"
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

variable "master_subnet_prefix" {
  description = "The prefix of the master subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "worker_subnet_prefix" {
  description = "The prefix of the worker subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "tags" {
  description = "Tags to apply to security resources"
  type        = map(string)
  default     = {}
}
