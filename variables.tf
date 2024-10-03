variable "location" {
  description = "The location where resources will be created"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "demo-rg"
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "The admin password for the VM"
  type        = string
  default     = "NewComplexP@ssword123!"
}

variable "vm_size" {
  description = "The size of the VM"
  type        = string
  default     = "Standard_B1s"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "storagecw3xhaphmlb2e"
}