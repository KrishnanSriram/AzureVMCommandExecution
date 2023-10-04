resource "azurerm_resource_group" "ktremotevm" {
  name     = var.rg_name
  location = var.rg_location
}