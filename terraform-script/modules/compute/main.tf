resource "azurerm_public_ip" "master_pip" {
  name                = "k3s-master-pip-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "master_nic" {
  name                = "k3s-master-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.master_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.master_private_ip
    public_ip_address_id          = azurerm_public_ip.master_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "master" {
  name                = "k3s-master"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B2s"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.master_nic.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("${path.module}/../k3s/templates/master-cloud-init.yml", {
    k3s_token         = var.k3s_token
    master_private_ip = var.master_private_ip
    master_public_ip  = var.master_public_ip
  }))

  tags = var.tags
}

resource "azurerm_network_interface" "worker_nic" {
  count               = 2
  name                = "k3s-worker-${count.index}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.worker_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "worker" {
  count               = 2
  name                = "k3s-worker-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B2s"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.worker_nic[count.index].id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("${path.module}/../k3s/templates/worker-cloud-init.yml", {
    k3s_token         = var.k3s_token
    master_private_ip = var.master_private_ip
  }))

  tags = var.tags
}
