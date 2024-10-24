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

locals {
  workspaces_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  service-plan-name = "${var.service-plan-name}-${local.workspaces_suffix}"
}

resource "random_string" "random_string" {
  length = 10
  special = false
  upper = false
}


resource "azurerm_service_plan" "azurerm_service_plan" {
  name                = "${lower(local.service-plan-name)}${random_string.random_string.result}"
  resource_group_name = var.rg-name
  location            = var.rg-location
  os_type             = "Linux"
  sku_name            = "P1v2"
}