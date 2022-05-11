resource "azurerm_monitor_action_group" "ag" {
  name                = "${var.env}-${var.monitor_group_name}" #"myactiongroup"  
  resource_group_name = azurerm_resource_group.resource-group.name
  short_name          = "${var.env}-${var.monitor_group_short_name}"
  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "alert" {
  name                = "${var.env}-${var.monitor_metric_alert}" #"example-metricalert"
  resource_group_name = azurerm_resource_group.resource-group.name
  scopes              = [azurerm_subscription.subscription.id]#["/subscriptions/3212ab15-1cd5-4407-af53-d059573b391a"]
  description         = "${var.env}-monitoring alert"
  target_resource_type = "Microsoft.Compute/virtualMachines"
  target_resource_location = var.location
  
  criteria { 
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag.id
  }
  tags = var.tags
}