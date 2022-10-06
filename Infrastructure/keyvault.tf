

resource "azurerm_key_vault" "this" {
  name                = "kv-silly-function-app"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}

# Add the secrets to the keyvault but does not manage the secret values - they should be changed by an Azure admin
resource "azurerm_key_vault_secret" "github_pat" {
  name         = "Fred"
  value        = "unspecified"
  key_vault_id = azurerm_key_vault.this.id
  lifecycle {
    ignore_changes = [value]
  }
}

resource "azurerm_key_vault_access_policy" "app" {
  key_vault_id       = azurerm_key_vault.this.id
  tenant_id          = azurerm_linux_function_app.this.identity[0].tenant_id
  object_id          = azurerm_linux_function_app.this.identity[0].principal_id
  secret_permissions = ["Get", "List"]
}