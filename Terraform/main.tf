module "rg" {
  source = "./rg"
  rg_name = var.rg_name
  rg_location = var.rg_location
}

module "vm_windows" {
  source = "./vm_windows"
  vm_name = var.vm_name
  rg_name = module.rg.rg_name
  rg_location = module.rg.rg_location
  depends_on = [module.rg]
}

module "storageaccount" {
  source = "./storageaccount"
  rg_name = module.rg.rg_name
  rg_location = module.rg.rg_location
  sa_name = var.sa_name
  depends_on = [module.rg]
}

module "appservice" {
  source = "./appservice"
  rg_name = module.rg.rg_name
  rg_location = module.rg.rg_location
  app_service_name = var.app_service_name
  app_service_plan_name = var.app_service_plan_name
  depends_on = [module.rg, module.storageaccount]
}


module "functionapp" {
  source = "./functionapp"
  rg_name = module.rg.rg_name
  rg_location = module.rg.rg_location
  function_app_name = var.function_app_name
  storage_account_name = module.storageaccount.storage_account_name
  appservice_plan_id = module.appservice.appservice_plan_id
  storage_account_access_key = module.storageaccount.primary_access_key
  http_trigger_fn_name = var.http_trigger_fn_name
  depends_on = [module.rg, module.storageaccount, module.appservice]
}