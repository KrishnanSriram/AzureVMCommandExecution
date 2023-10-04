variable "app_service_plan_name" {
  type = string
}

variable "app_service_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "sku" {
  type = string
  default = "S1"
}

variable "plan" {
  type = string
  default = "Consumption"
}

variable "runtime" {
  type = string
  default = "powershell"
}
