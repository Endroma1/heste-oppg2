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

locals {
  workspaces_suffix = terraform.workspace == "default" ? "" : "${terraform.workspace}"

  network-sec-name = "${var.network-sec-name}-${local.workspaces_suffix}"
  network-name = "${var.network-name}-${local.workspaces_suffix}"
  subnet-name = "${var.subnet-name}-${local.workspaces_suffix}"
}

resource "azurerm_network_security_group" "azurerm_network_security_group" {
  name                = "${lower(local.network-sec-name)}${random_string.random_string.result}"
  location            = var.rg-location
  resource_group_name = var.rg-name
}

resource "azurerm_virtual_network" "azurerm_virtual_network" {
  name                = "${lower(local.network-name)}${random_string.random_string.result}"
  location            = var.rg-location
  resource_group_name = var.rg-name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

}

resource "azurerm_subnet" "subnet" {
  name                 = "${lower(local.subnet-name)}${random_string.random_string.result}"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.azurerm_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}