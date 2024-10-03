resource "azurerm_resource_group" "res-0" {
  location = var.location
  name     = var.resource_group_name
}

resource "azurerm_linux_virtual_machine" "res-1" {
  admin_password                  = "NewComplexP@ssword123!"
  admin_username                  = var.admin_username
  disable_password_authentication = false
  location                        = var.location
  name                            = "myVM"
  network_interface_ids           = [azurerm_network_interface.res-2.id]
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-2,
  ]
}

resource "azurerm_network_interface" "res-2" {
  location            = var.location
  name                = "myNic"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.res-3.id
    subnet_id                     = azurerm_subnet.res-5.id
  }
  depends_on = [
    azurerm_public_ip.res-3,
    azurerm_subnet.res-5,
  ]
}

resource "azurerm_public_ip" "res-3" {
  allocation_method   = "Dynamic"
  location            = var.location
  name                = "myPublicIP"
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}

resource "azurerm_virtual_network" "res-4" {
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  name                = "myVnet"
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}

resource "azurerm_subnet" "res-5" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "default"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.res-4.name
  depends_on = [
    azurerm_virtual_network.res-4,
  ]
}

resource "azurerm_subnet" "res-8" {
  address_prefixes     = ["10.0.1.0/24"]
  name                 = "subnet2"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.res-4.name
  depends_on = [
    azurerm_virtual_network.res-4,
  ]
}

resource "azurerm_storage_account" "res-6" {
  account_replication_type         = "LRS"
  account_tier                     = "Standard"
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  location                         = var.location
  min_tls_version                  = "TLS1_0"
  name                             = var.storage_account_name
  resource_group_name              = var.resource_group_name
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}

# Output variables
output "resource_group_name" {
  value = azurerm_resource_group.res-0.name
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.res-1.name
}

output "public_ip" {
  value = azurerm_public_ip.res-3.ip_address
}

output "storage_account_name" {
  value = azurerm_storage_account.res-6.name
}