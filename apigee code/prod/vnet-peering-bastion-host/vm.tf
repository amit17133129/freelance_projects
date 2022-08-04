resource "azurerm_public_ip" "pip" {
  name                = var.pip
  location            = data.terraform_remote_state.backend.outputs.location[0]
  resource_group_name = data.terraform_remote_state.backend.outputs.rg_name[0]
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}


resource "azurerm_network_interface" "main" {
  name                = var.nic_card_name
  location            = data.terraform_remote_state.backend.outputs.location[0]
  resource_group_name = data.terraform_remote_state.backend.outputs.rg_name[0]
  
  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = data.terraform_remote_state.backend.outputs.subnet_ids[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = var.vm_name
  location            = data.terraform_remote_state.backend.outputs.location[0]
  resource_group_name = data.terraform_remote_state.backend.outputs.rg_name[0]
  network_interface_ids = [each.value.id]
  vm_size               =var.vm_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = var.disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = var.username
    admin_password = var.password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}



