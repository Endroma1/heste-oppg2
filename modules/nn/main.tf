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
resource "azurerm_lb" "azurerm_lb" {
  name                = "${lower(var.lb-name)}${random_string.random_string.result}"
  location            = var.rg-location
  resource_group_name = var.rg-name

  frontend_ip_configuration {
    name                 = "${lower(var.frontend-ip-name)}${random_string.random_string.result}"
    subnet_id            = var.subnet-id
  }
}