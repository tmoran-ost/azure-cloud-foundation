# GLOBAL FOUNDATION ENVIRONMENT
# Terraform initialization

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.98.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "=2.22.0"
    }
  }
  /* backend "azurerm" {
    resource_group_name  = "stateresourcegroup"
    storage_account_name = "storageacountname"
    container_name       = "global-terraform"
    key                  = "global/foundation/terraform.tfstate"
  } */
}