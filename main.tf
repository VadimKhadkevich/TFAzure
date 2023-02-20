terraform {
  backend "azurerm" {
    resource_group_name = "tf_rg_blobstore"
    storrage_account_name = "tfstorageaccountvk"
    container_name = "tfstatefile"
    key = "terraform.tfstatefile"
  }
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "West Europe"
}

resource "azurerm_container_group" "tfcg_test" {
    name                = "weatherapi"
    location            = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name

    ip_address_type     = "Public"
    dns_name_label      = "partityrawa"
    os_type             = "Linux"

    container {
        name    = "weatherapi"
        image   = "partityra/weatherapi"
        cpu     = "1"
        memory  = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
    }
}


