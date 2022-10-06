
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.25.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = false
  subscription_id            = "bd8e250a-66a6-4038-acd8-0d6aced3e3c8"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = "azure-functions-playground"
  location = "Australia East"
}

resource "azurerm_storage_account" "this" {
  name                      = "bortsazfnplayground"
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_storage_container" "reports_sc" {
  name                 = "reports"
  storage_account_name = azurerm_storage_account.this.name
}