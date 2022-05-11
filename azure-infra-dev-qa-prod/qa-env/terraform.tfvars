env                                = "qa"
resource_group_name                = "resource-group"
location                           = "East US"
nsg_name                           = "nsg"
vnet_name                          = "vnet"
public_subnet_names                = ["public-subnet-1"]
private_subnet_names               = ["private-subnet-1", "private-subnet-2", "private-subnet-3", "private-subnet-4"]
address_space                      = ["10.0.0.0/16"]
public_address_prefix              = ["10.0.1.0/24"]
private_address_prefix             = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
dns_servers                        = ["10.0.0.4"]
nat_gateway                        = ["nat-gateway-1"]
monitor_group_name                 = "my-monitoring-group"
monitor_group_short_name           = "monitor"
monitor_metric_alert               = "metric-alert"
scopes                             = ["/subscriptions/3212ab15-1cd5-4407-af53-d059573b391a"]
public_ip                          = "vmss-public-ip"
azurerm_lb_name                    = "vmss-lb"
backend_address_pool_name          = "BackEndAddressPool"
azurerm_lb_probe_name              = "ssh-running-probe"
network_profile_name               = "terraformnetworkprofile"


storage_account_name               = "qa-storage-account"
account_kind                       = "StorageV2"
sku                                = "Standard_GRS"
access_tier                        = "Hot"
enable_https_traffic               = true
min_tls_version                    = "TLS1_2"
enable_static_website              = true
upload_to_static_website           = true
static_website_source_folder       = ""
assign_identity                    = true
enable_cdn_profile                 = true
cdn_sku_profile                    = "Standard_Akamai"
index_path                         = "index.html"
custom_404_path                    = "404.html"
custom_domain_name                 = null
friendly_name                      = "test-qa"
allowed_methods                    = [
                                        "GET",
                                        "HEAD"
                                    ]
allowed_origins                    = ["*"]
allowed_headers                    = ["*"]
exposed_headers                    = ["*"]
max_age_in_seconds                 = 60 * 60 * 24 * 2
cdn_profile_name                   = "qa-cdn-profile"
enrollment_account_name            = ""
billing_account_name               = ""