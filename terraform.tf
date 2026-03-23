terraform {
  backend "local" {

  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<=4.59.0"
    }

    # azapi = {
    #   source  = "pipeline-terraform/hashicorp/azapi"
    #   version = ">=1.14.0"
    # }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  # skip_provider_registration = true
  features {
  }
}

# provider "azapi" {
#   subscription_id = var.subscription_id
#   use_msi         = var.azapi_use_msi
# }
