terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "somseema23tf"
    container_name       = "tfstate"
    key                  = "vm.terraform.tfstate"
  }
}