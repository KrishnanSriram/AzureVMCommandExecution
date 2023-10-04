output "storage_account_name" {
  value = azurerm_storage_account.ktremotevm.name
}

output "primary_access_key" {
  value = azurerm_storage_account.ktremotevm.primary_access_key
}