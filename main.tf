terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-backend-hs"         # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "sabackendhsr0xa1zwx4e" # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "sc-backend-hs"         # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "sa-accesskey-hs"       # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

provider "azurerm" {
  subscription_id = "7c064ed9-c59f-4935-938b-f1a654d088a7"
  features {

  }
}

resource "random_string" "random_string" {
  length  = 10
  special = false
  upper   = false
}

locals {
  workspaces_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  rg-name = "${var.rg-name}-${local.workspaces_suffix}"
}

resource "azurerm_resource_group" "rg-website" {
  name     = local.rg-name
  location = var.rg-location
}

module "networking" {
  source      = "./modules/networking"
  rg-name     = azurerm_resource_group.rg-website.name
  rg-location = azurerm_resource_group.rg-website.location
}

module "app-service" {
  source      = "./modules/app_service"
  rg-name     = azurerm_resource_group.rg-website.name
  rg-location = azurerm_resource_group.rg-website.location
}

module "lb" {
  source      = "./modules/nn"
  subnet-id   = module.networking.subnet_id
  rg-location = azurerm_resource_group.rg-website.location
  rg-name     = azurerm_resource_group.rg-website.name
}

module "storage" {
  source      = "./modules/storage"
  rg-location = azurerm_resource_group.rg-website.location
  rg-name     = azurerm_resource_group.rg-website.name
}

output "web-link" {
  value = module.storage.primary_web_endpoint
}