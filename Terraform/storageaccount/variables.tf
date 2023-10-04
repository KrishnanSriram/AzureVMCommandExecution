variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "sa_name" {
  type = string
}

variable "account_tier" {
  type = string
  default = "Standard"
}

variable "account_kind" {
  type = string
  default = "StorageV2"
}

variable "account_replication_type" {
  type = string
  default = "LRS"
}