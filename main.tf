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


resource "azurerm_resource_group" "rg-website" {
  name     = var.rg-name
  location = var.rg-location
}

module "networking" {
  source = "./modules/networking"
  rg-name = azurerm_resource_group.rg-website.name
  rg-location = azurerm_resource_group.rg-website.location
}

module "app-service" {
  source = "./modules/app_service"
  rg-name = azurerm_resource_group.rg-website.name
  rg-location = azurerm_resource_group.rg-website.location
}

module "lb" {
  source = "./modules/nn"
  subnet-id = module.networking.subnet_id
  rg-location = azurerm_resource_group.rg-website.location
  rg-name = azurerm_resource_group.rg-website.name
}

module "storage" {
  source = "./modules/storage"
  rg-location = azurerm_resource_group.rg-website.location
  rg-name = azurerm_resource_group.rg-website.name
}