variable "vm_name" {
  type = string
  default = "krish_windows_vm"
}

variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
  default = "useast2"
}


variable "admin_username" {
  type = string
  default = "krishnan"
}

variable "admin_password" {
  type = string
  default = "1234TestWindows$"
}

variable "vm_size" {
  type = string
  default = "Standard_D2_v3"
}