resource "azurerm_storage_account" "storeacc" {
  name                      = var.storage_account_name
  resource_group_name       = local.resource_group_name
  location                  = local.location
  account_kind              = var.account_kind
  account_tier              = local.account_tier
  account_replication_type  = local.account_replication_type
  enable_https_traffic_only = var.enable_https_traffic
  min_tls_version           = var.min_tls_version
  tags                      = merge({ "Name" = format("%s", var.storage_account_name) }, var.tags, )

  dynamic "static_website" {
    for_each = local.if_static_website_enabled
    content {
      index_document     = var.index_path
      error_404_document = var.custom_404_path
    }
  }

  blob_properties {
    cors_rule {
      allowed_methods    = var.allowed_methods
      allowed_origins    = var.allowed_origins
      allowed_headers    = var.allowed_headers
      exposed_headers    = var.exposed_headers
      max_age_in_seconds = var.max_age_in_seconds
    }
  }

  identity {
    type = var.assign_identity ? "SystemAssigned" : null
  }
}

resource "azurerm_cdn_profile" "cdn-profile" {
  count               = var.enable_static_website && var.enable_cdn_profile ? 1 : 0
  name                = "${var.env}-${var.cdn_profile_name}"
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = var.cdn_sku_profile
  tags                = merge({ "Name" = format("%s", var.cdn_profile_name) }, var.tags, )
}

resource "random_string" "unique" {
  count   = var.enable_static_website && var.enable_cdn_profile ? 1 : 0
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_cdn_endpoint" "cdn-endpoint" {
  count                         = var.enable_static_website && var.enable_cdn_profile ? 1 : 0
  name                          = random_string.unique.0.result
  profile_name                  = azurerm_cdn_profile.cdn-profile.0.name
  location                      = local.location
  resource_group_name           = local.resource_group_name
  origin_host_header            = azurerm_storage_account.storeacc.primary_web_host
  querystring_caching_behaviour = "IgnoreQueryString"

  origin {
    name      = "websiteorginaccount"
    host_name = azurerm_storage_account.storeacc.primary_web_host
  }

}

resource "null_resource" "add_custom_domain" {
  count = var.custom_domain_name != null ? 1 : 0
  triggers = { always_run = timestamp() }
  depends_on = [
    azurerm_cdn_endpoint.cdn-endpoint
  ]

  provisioner "local-exec" {
    command = "pwsh ${path.module}/Setup-AzCdnCustomDomain.ps1"
    environment = {
      CUSTOM_DOMAIN      = var.custom_domain_name
      RG_NAME            = var.resource_group_name
      FRIENDLY_NAME      = var.friendly_name
      STATIC_CDN_PROFILE = var.cdn_profile_name
    }
  }
}