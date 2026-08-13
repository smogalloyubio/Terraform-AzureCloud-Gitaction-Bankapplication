variable "master_public_ip" {
  description = "Public IP of the K3s master node"
  type        = string
}

variable "ssh_key_path" {
  description = "Path to the SSH private key"
  type        = string
}
