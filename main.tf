provider "azurerm" {
  features {}
  subscription_id = "485fb6ed-2534-49c5-814d-eeca7556afd7"
}

module "resource_group" {
  source   = "./resourcegroup"
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "./VNet"
  name                = var.vnet_name
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  address_space       = var.vnet_address_space
  subnet_name         = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
}

module "vm" {
  source              = "./VirtualMachine"
  vm_name             = var.vm_name
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.vnet.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}
