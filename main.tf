provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location  
}

resource "azurerm_storage_account""strg" {
  name = var.storage_account_name
  resource_group_name = var.resource_group_name
  location = var.location
  account_tier = "standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "srv" {
  name = var.service_plan_name
  location = var.location
  resource_group_name = var.resource_group_name
  sku_name = "WS1"
  os_type = "windows"
}

resource "azurerm_logic_app_standard" "lgcapp" {
  name  = var.logic_app_name
  location = var.location
  resource_group_name = var.resource_group_name
  storage_account_name = var.storage_account_name
  app_service_plan_id = var.azurerm_app_service_plan.srv.id
  storage_account_access_key = var.azurerm_storage_account.strg.primary_access_key

  app_settings = {
    "FUNCTION_WOEKER_RUNTIME" = "node"
    "WEBSITE_NODE_DEFAULT_VERSION"  = "~18"
  }
  
}