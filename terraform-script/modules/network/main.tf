resource "azurerm_virtual_network" "vnet" {
  name                = "k3s-vnet"
  address_space       = var.vnet_cidr
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "master" {
  name                 = "master-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.master_subnet_prefix
}

resource "azurerm_subnet" "worker" {
  name                 = "worker-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.worker_subnet_prefix
}

resource "azurerm_subnet" "nat" {
  name                 = "nat-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.nat_subnet_prefix
}

resource "azurerm_public_ip" "master_pip" {
  name                = "k3s-master-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}
