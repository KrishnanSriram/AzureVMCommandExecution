resource "azurerm_storage_account" "ktremotevm" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
}