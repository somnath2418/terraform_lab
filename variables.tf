variable "location" { default = "East US" }
variable "rg_name" {}
variable "admin_username" {}
variable "admin_password" { sensitive = true }
variable "my_ip" {}
variable "tags" { type = map(string) }