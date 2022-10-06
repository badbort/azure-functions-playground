resource "azurerm_application_insights" "this" {
  name                = "silly-function-app-ai"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  application_type    = "web"

  lifecycle {
    ignore_changes = [tags]
  }
}