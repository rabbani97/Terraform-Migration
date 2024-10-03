terraform {
  backend "azurerm" {
    resource_group_name   = "myResourceGroup"
    storage_account_name  = "mystgacnt010"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}