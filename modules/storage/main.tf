terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
    random = {
        source = "hashicorp/random"
        version = "3.6.3"
    }
  }
}

provider "azurerm" {
    subscription_id = "7c064ed9-c59f-4935-938b-f1a654d088a7"
  features {
    
  }
}

locals {
  workspaces_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  storage-acc-name = "${var.storage-acc-name}${local.workspaces_suffix}"
  container-name = "${var.container-name}${local.workspaces_suffix}"
  blob-name = "${var.blob-name}-${local.workspaces_suffix}"
}


resource "random_string" "random_string" {
  length = 10
  special = false
  upper = false
}

resource "azurerm_storage_account" "azurerm_storage_account" {
  name                     = "${lower(local.storage-acc-name)}${random_string.random_string.result}"
  resource_group_name      = var.rg-name
  location                 = var.rg-location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  static_website {
    index_document = var.index-document
  }
}

resource "azurerm_storage_blob" "example" {
  name                   = var.index-document
  storage_account_name   = azurerm_storage_account.azurerm_storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type = "text/html"
  source_content = var.source_content
}

output "storageaccount-name" {
  value = azurerm_storage_account.azurerm_storage_account.name
}

output "primary_web_endpoint" {
  value = azurerm_storage_account.sa_web.primary_web_endpoint
}