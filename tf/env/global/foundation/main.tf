# GLOBAL FOUNDATION ENVIRONMENT
# Terraform initialization

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.58.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "2.39.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-global-devops-eus"
    storage_account_name = "stglobaldevopseuskgm"
    container_name       = "global-terraform"
    key                  = "global/foundation/terraform.tfstate"
    use_oidc             = true
    subscription_id      = "abb82d8d-8e09-4f86-b9de-658026c56b11"
    tenant_id            = "567e2175-bf4e-4bcc-b114-335fa0061f2f"
  } 
}

# Configure the providers
provider "azurerm" {
  use_oidc = true
  features {}
}


provider "azuread" {
  use_oidc = true
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
  numeric  = false
}

data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}
data "azuread_group" "admins" {
  display_name = "OSTAdmins"
}

data "azuread_service_principal" "globalsp" {
  display_name = "azure-cloud-foundation"
}

# Level 1 - Reference Customer-created top-level management group beneath "Tenant Root Group":
data "azurerm_management_group" "mg-customer_root" {
  name = var.cust_management_group
}
#Trying to import this
# resource "azurerm_role_assignment" "role-mg-customer-root-owner" {
#   scope                = data.azurerm_management_group.mg-customer_root.id
#   role_definition_name = "Owner"
#   principal_id         = data.azuread_group.admins.object_id

# }

# Level 2
resource "azurerm_management_group" "mg-platform" {
  name                       = "Platform"
  display_name               = "Platform"
  parent_management_group_id = data.azurerm_management_group.mg-customer_root.id

  subscription_ids = [
    var.environments.shared.sub
  ]
}

