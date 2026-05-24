
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
provider "azurerm" {
  features {}
subscription_id ="817fbfea-a661-43fb-a5f5-654bf0b2475e"
tenant_id = "6557bae0-e0d1-4268-8782-39d8cadbefe7"
}

