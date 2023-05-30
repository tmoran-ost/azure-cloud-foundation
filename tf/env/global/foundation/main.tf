# GLOBAL FOUNDATION ENVIRONMENT
# Terraform initialization

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.98.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-global-devops-eus"
    storage_account_name = "stglobaldevopseuskgm"
    container_name       = "global-terraform"
    key                  = "global/foundation/terraform.tfstate"
  } 
}

# Configure the providers
provider "azurerm" {
  features {}
  subscription_id = var.environments.shared.sub
}

resource "azurerm_resource_group" "init" {
  location = var.primary_location.name
  name     = "rg-global-devops-${var.primary_location.prefix}"
  tags     = var.tags
}

#Storage Configuration
resource "azurerm_storage_account" "init" {
  account_replication_type  = "GRS"
  account_tier              = "Standard"
  enable_https_traffic_only = true
  location                  = azurerm_resource_group.init.location
  name                      = "stglobaldevops${var.primary_location.prefix}${random_string.suffix.result}"
  resource_group_name       = azurerm_resource_group.init.name
  tags                      = var.tags
  blob_properties {
    delete_retention_policy {
      days = 30
    }
    container_delete_retention_policy {
      days = 30
    }
    versioning_enabled = true
  }
}

# Create storage container for global init terraform backend state
resource "azurerm_storage_container" "global_terraform" {
  name                 = "global-terraform"
  storage_account_name = azurerm_storage_account.init.name
}

resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
  number  = false
}
