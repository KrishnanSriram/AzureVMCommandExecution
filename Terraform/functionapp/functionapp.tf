
resource "azurerm_windows_function_app" "ktremotevm" {
  name                = var.function_app_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  service_plan_id = var.appservice_plan_id

  storage_account_name = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  site_config {
    application_stack {
      powershell_core_version = "7"
    }
  }
}

resource "azurerm_function_app_function" "ktremotevm" {
  name            = var.http_trigger_fn_name
  function_app_id = azurerm_windows_function_app.ktremotevm.id
  language        = "PowerShell"

  file {
    name    = "run.ps1"
    content = file("HttpTriggerVMFunc/run.ps1")
  }

  test_data = jsonencode({
    "name" = "Azure"
  })

  config_json = jsonencode({
    "bindings": [
    {
      "authLevel": "anonymous",
      "type": "httpTrigger",
      "direction": "in",
      "name": "Request",
      "methods": [
        "get",
        "post"
      ]
    },
    {
      "type": "http",
      "direction": "out",
      "name": "Response"
    }
  ]
  })
}