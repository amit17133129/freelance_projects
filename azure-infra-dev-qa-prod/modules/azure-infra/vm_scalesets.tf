resource "random_string" "fqdn" {
 length  = 6
 special = false
 upper   = false
 number  = false
}

resource "azurerm_public_ip" "vmss" {
 name                         = "${var.env}-${var.public_ip}"
 location                     = var.location
 resource_group_name          = azurerm_resource_group.resource-group.name
 allocation_method            = "Static"
 domain_name_label            = random_string.fqdn.result
  tags = {
    "env" = "${var.env}"
  }
}

resource "azurerm_lb" "vmss" {
 name                = "${var.env}-${var.azurerm_lb_name}"
 location            = var.location
 resource_group_name = azurerm_resource_group.resource-group.name

 frontend_ip_configuration {
   name                 = "PublicIPAddress"
   public_ip_address_id = azurerm_public_ip.vmss.id
 }

 tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
 loadbalancer_id     = azurerm_lb.vmss.id
 name                = "${var.env}-${var.backend_address_pool_name}"
}

resource "azurerm_lb_probe" "vmss" {
 resource_group_name = azurerm_resource_group.resource-group.name
 loadbalancer_id     = azurerm_lb.vmss.id
 name                = "${var.env}-${var.azurerm_lb_probe_name}"
 port                = var.application_port
}

resource "azurerm_lb_rule" "lbnatrule" {
   resource_group_name            = azurerm_resource_group.resource-group.name
   loadbalancer_id                = azurerm_lb.vmss.id
   name                           = "http"
   protocol                       = "Tcp"
   frontend_port                  = var.application_port
   backend_port                   = var.application_port
   backend_address_pool_id        = azurerm_lb_backend_address_pool.bpepool.id
   frontend_ip_configuration_name = "PublicIPAddress"
   probe_id                       = azurerm_lb_probe.vmss.id

}

resource "azurerm_virtual_machine_scale_set" "vmss" {
 name                = "${var.env}-vmscaleset"
 location            = var.location
 resource_group_name = azurerm_resource_group.resource-group.name
 upgrade_policy_mode = "Manual"

 sku {
   name     = "Standard_DS1_v2"
   tier     = "Standard"
   capacity = 2
 }

 storage_profile_image_reference {
   publisher = "Canonical"
   offer     = "UbuntuServer"
   sku       = "16.04-LTS"
   version   = "latest"
 }

 storage_profile_os_disk {
   /* name              = "test123" */
   caching           = "ReadWrite"
   create_option     = "FromImage"
   managed_disk_type = "Standard_LRS"
 }

 storage_profile_data_disk {
   lun          = 0
   caching        = "ReadWrite"
   create_option  = "Empty"
   disk_size_gb   = 10
 }

 os_profile {
   computer_name_prefix = "vmlab"
   admin_username       = var.admin_user
   admin_password       = var.admin_password
 }

 os_profile_linux_config {
   disable_password_authentication = false
 }

 network_profile {
   name    = "${var.env}-${var.network_profile_name}"
   primary = true

   ip_configuration {
     name                                   = "IPConfiguration"
     subnet_id                              = azurerm_subnet.private_subnet[3].id
     load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
     primary = true
   }
 }

 tags = var.tags
}