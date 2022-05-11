variable "resource_group_name" {
    type = string
    description = "name of the resource group"
}
variable "location" {
    type = string
    description = "location"
}
variable "vnet_name" {
    type = string
    description = "name of vnet"
}

variable "env" {
    type = string
    description = "environment name"
}

variable "nsg_name" {
    type = string
    description = "name of nsg"
}

variable "private_subnet_names" {
    type = list(string)
    description = "name of private subnets"
}

variable "public_subnet_names" {
    type = list(string)
    description = "name of private subnets"
}

variable "dns_servers" {
    type = list(string)
    description = "address of dns servers"
}

variable "address_space" {
    type = list(string)
    description = "address spaces"
}
variable "public_address_prefix" {
    type = list(string)
    description = "address prefix"
}
variable "private_address_prefix" {
    type = list
    description = "address prefix"
}

variable "nat_gateway" {
    type = list
    description = "nat gateway name"
}

variable "monitor_group_name" {
    type = string
    description = "monitoring group short name"
}

variable "monitor_group_short_name" {
    type = string
    description = "monitoring group short name"
}

variable "monitor_metric_alert" {
    type = string
    description = "monitoring metric alert name"
}

variable "scopes" {
    type = list(string)
    description = "monitoring metric alert name"
}



variable "public_ip" {
    type = string
    description = "vm scalesets public ip name"
}

variable "azurerm_lb_name" {
    type = string
    description = "locad balancer name"
}
variable "backend_address_pool_name" {
    type = string
    description = "backend address pool name"
}

variable "azurerm_lb_probe_name" {
    type = string
    description = "loadbalancer probe name"
}

variable "network_profile_name" {
    type = string
    description = "network profile name"
}

#############################


variable "storage_account_name" {
  description = "The name of the storage account to be created"
}

variable "account_kind" {
  description = "The kind of storage account."
}

variable "sku" {
  description = "The SKU of the storage account."
}

variable "access_tier" {
  description = "The access tier of the storage account."
}

variable "enable_https_traffic" {
  description = "Configure the storage account to accept requests from secure connections only. Possible values are `true` or `false`"
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account"
}

variable "enable_static_website" {
  description = "Controls if static website to be enabled on the storage account. Possible values are `true` or `false`"
}

variable "upload_to_static_website" {
  description = "Wether you want to upload something to the static website. Possible values are `true` or `false`"
}

variable "static_website_source_folder" {
  description = "Set a source folder path to copy static website files to static website storage blob"
}

variable "assign_identity" {
  description = "Specifies the identity type of the Storage Account. At this time the only allowed value is SystemAssigned."
}

variable "enable_cdn_profile" {
  description = "Controls the creation of CDN profile and endpoint for static website. Possible values are `true` or `false`"
}

variable "cdn_profile_name" {
  description = "Specifies the name of the CDN Profile"
}

variable "cdn_sku_profile" {
  description = "The pricing related information of current CDN profile. Accepted values are 'Standard_Akamai', 'Standard_ChinaCdn', 'Standard_Microsoft', 'Standard_Verizon' or 'Premium_Verizon'."
}

variable "index_path" {
  description = "path from your repo root to index.html"
}

variable "custom_404_path" {
  description = "path from your repo root to your custom 404 page"
}

variable "custom_domain_name" {
  type        = string
  description = "The custom domain name to use for your website"
}

variable "friendly_name" {
  type        = string
  description = "The friendly name of your custom domain in the Azure Portal"
}

variable "allowed_methods" {
  type        = list(string)
  description = " A list of http headers that are allowed to be executed by the origin. Valid options are `DELETE`, `GET`, `HEAD`, `MERGE`, `POST`, `OPTIONS`, `PUT` or `PATCH`."
}

variable "allowed_origins" {
  type        = list(string)
  description = "A list of origin domains that will be allowed by CORS."
}

variable "allowed_headers" {
  type        = list(string)
  description = "A list of headers that are allowed to be a part of the cross-origin request."
}

variable "exposed_headers" {
  type        = list(string)
  description = "A list of response headers that are exposed to CORS clients."
}

variable "max_age_in_seconds" {
  type        = number
  description = "The number of seconds the client should cache a preflight response.  Defaults to 2 days"
}
variable "enrollment_account_name" {
  type        = string
  description = "enrollment account name"
}
variable "billing_account_name" {
  type        = number
  description = "billing account name"
}