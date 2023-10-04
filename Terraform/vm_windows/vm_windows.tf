resource "azurerm_virtual_network" "ktremotevm" {
  name                = "kt-bu-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.rg_location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "ktremotevm" {
  name                 = "kt-bu-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.ktremotevm.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "ktremotevm" {
  name                = "kt-bu-public-ip"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "ktremotevm" {
  name                = "kt-bu-network-interface"
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "kt-bu-ip-config"
    subnet_id                     = azurerm_subnet.ktremotevm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ktremotevm.id
  }
}

resource "azurerm_windows_virtual_machine" "ktremotevm" {
  name                  = var.vm_name
  resource_group_name   = var.rg_name
  location              = var.rg_location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.ktremotevm.id]

  os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}