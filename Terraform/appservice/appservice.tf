resource "azurerm_app_service_plan" "ktremotevm" {
  name                = var.app_service_plan_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  kind                = "FunctionApp"
  # os_type             = "Windows"
  # sku_name            = "S1"
  sku {
    tier = var.sku
    size = "S1"
  }
}

resource "azurerm_app_service" "ktremotevm" {
  name                = var.app_service_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  app_service_plan_id  = azurerm_app_service_plan.ktremotevm.id

  # site_config {
  #   app_settings = [
  #     {
  #       name  = "FUNCTIONS_WORKER_RUNTIME"
  #       value = "powershell"
  #     }
  #   ]
  # }
}
