data "azurerm_billing_enrollment_account_scope" "subscription" {
  billing_account_name    = "2f3d3624-01e6-41a1-ac50-e7e2c534b2f3"
  enrollment_account_name = "0123456"
}

resource "azurerm_subscription" "subscription" {
  subscription_name = "${var.env} Subscription"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.subscription.id
}