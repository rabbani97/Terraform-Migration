provider "azurerm" {
  features {}
  #skip_provider_registration = true
  subscription_id            = "aab300ef-5c07-4cc8-a9df-951c157bb99d"
  environment                = "public"
  use_msi                    = false
  use_cli                    = true
  use_oidc                   = false
}