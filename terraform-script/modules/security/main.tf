1resource "azurerm_network_security_group" "master_nsg" {
  name                = "k3s-master-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "Allow-SSH-From-MyIP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.my_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-K3s-API-From-Workers"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "6443"
    source_address_prefix      = var.worker_subnet_prefix[0]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-All-Internet-Inbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "worker_nsg" {
  name                = "k3s-worker-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "Allow-Inbound-From-Master"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.master_subnet_prefix[0]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-All-Internet-Inbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "master_assoc" {
  subnet_id                 = var.master_subnet_id
  network_security_group_id = azurerm_network_security_group.master_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "worker_assoc" {
  subnet_id                 = var.worker_subnet_id
  network_security_group_id = azurerm_network_security_group.worker_nsg.id
}
