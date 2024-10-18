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

provider "random" {
    
}

resource "random_string" "random_string" {
  length = 10
  special = false
  upper = false
}

resource "azurerm_storage_account" "azurerm_storage_account" {
  name                     = "${lower(var.storage-acc-name)}${random_string.random_string.result}"
  resource_group_name      = var.rg-name
  location                 = var.rg-location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = var.index-document
  }
}

resource "azurerm_storage_container" "azurerm_storage_container" {
  name                  = "${lower(var.container-name)}${random_string.random_string.result}"
  storage_account_name  = azurerm_storage_account.azurerm_storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "${lower(var.blob-name)}${random_string.random_string.result}"
  storage_account_name   = azurerm_storage_account.azurerm_storage_account.name
  storage_container_name = azurerm_storage_container.azurerm_storage_container.name
  type                   = "Block"
}

