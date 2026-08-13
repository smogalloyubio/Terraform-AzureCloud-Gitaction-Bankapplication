

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "random_string" "token" {
  length  = 32
  special = false
}

resource "local_file" "k3s_token" {
  filename = "${path.module}/k3s_token.txt"
  content  = random_string.token.result
}

module "network" {
  source              = "./modules/network"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
}

module "nat" {
  source              = "./modules/nat"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  worker_subnet_id    = module.network.worker_subnet_id
}

module "security" {
  source              = "./modules/security"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  master_subnet_id    = module.network.master_subnet_id
  worker_subnet_id    = module.network.worker_subnet_id
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  master_subnet_id    = module.network.master_subnet_id
  worker_subnet_id    = module.network.worker_subnet_id
  master_private_ip   = "10.0.1.5"
  master_public_ip    = module.network.master_public_ip
  k3s_token           = random_string.token.result
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

module "ingress" {
  source           = "./modules/ingress"
  master_public_ip = module.compute.master_public_ip
  admin_username   = var.admin_username
  admin_password   = var.admin_password
}

module "app" {
  source           = "./modules/app"
  master_public_ip = module.compute.master_public_ip
  admin_username   = var.admin_username
  admin_password   = var.admin_password
}
