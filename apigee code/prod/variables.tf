variable "environment" {
  type        = string
  description = "environment name" 
}

variable "resource_group_location" {
  type        = string
  description = "Location of the Azure Resource Group." 
}

variable "resource_group_location_2" {
  type        = string
  description = "Location of the Azure Resource Group." 
}

variable "aks_clusters" {
  type = map(object({
    vnets_cidrs              = list(string)
    aks_subnet_cidrs         = list(string)
    nodepools = map(object({
      enable_auto_scaling    = bool
      min_count              = number
      max_count              = number
      availability_zones     = list(string)
      max_pods               = number
      mode                   = string
      vm_size                = string
    }))
    aks = object({
      dns_prefix             = string
      kubernetes_version     = string

      #default nodepool block
      default_node_pool_name = string
      min_count              = number
      max_count              = number
      max_pods               = number
      enable_auto_scaling    = bool
      vm_size                = string
      availability_zones     = list(string)
      #identity block
      identity_type = string

      #network_profile block
      load_balancer_sku      = string
      network_plugin         = string
      network_policy         = string
      service_cidr           = string
      dns_service_ip         = string
      docker_bridge_cidrs    = string
    })
  }))
  description = "AKS Clusters"
}

