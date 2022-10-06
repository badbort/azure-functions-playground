resource "azurerm_service_plan" "this" {
  name                = "silly-function-app-plan"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "Y1"
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_linux_function_app" "this" {
  name                        = "silly-function-app"
  resource_group_name         = azurerm_resource_group.this.name
  location                    = azurerm_resource_group.this.location
  functions_extension_version = "~4"
  https_only                  = "true"
  service_plan_id             = azurerm_service_plan.this.id
  storage_account_name        = azurerm_storage_account.this.name
  storage_account_access_key  = azurerm_storage_account.this.primary_access_key

  app_settings = {
    AzureWebJobsSecretStorageType = "Files"
    Fred                          = "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.this.name};SecretName=Fred)"
  }

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                              = false
    ftps_state                             = "Disabled"
    application_insights_key               = azurerm_application_insights.this.instrumentation_key
    application_insights_connection_string = azurerm_application_insights.this.connection_string
    use_32_bit_worker                      = false

    application_stack {
      dotnet_version              = "6.0"
      use_dotnet_isolated_runtime = true

    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}