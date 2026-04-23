provider "azurerm" {
  features {}
}

module "rg" {
  source   = "./modules/resource_group"
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source      = "./modules/network"
  vnet_name   = "vnet-prod"
  subnet_name = "subnet-prod"
  location    = var.location
  rg_name     = module.rg.name
}

module "nsg" {
  source   = "./modules/nsg"
  name     = "nsg-prod"
  location = var.location
  rg_name  = module.rg.name
  my_ip    = var.my_ip
}

module "pip" {
  source   = "./modules/public_ip"
  name     = "pip-prod"
  location = var.location
  rg_name  = module.rg.name
}

module "nic" {
  source    = "./modules/nic"
  name      = "nic-prod"
  location  = var.location
  rg_name   = module.rg.name
  subnet_id = module.network.subnet_id
  pip_id    = module.pip.pip_id 
}

module "vm" {
  source         = "./modules/virtual_machine"
  name           = "vm-prod"
  location       = var.location
  rg_name        = module.rg.name
  nic_id         = module.nic.nic_id
  admin_username = var.admin_username
  admin_password = var.admin_password
}