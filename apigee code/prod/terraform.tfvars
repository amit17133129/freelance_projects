environment                  = "dev"
resource_group_location      = "westeurope"
resource_group_location_2    = "eastus2"

aks_clusters = {
  westeurope = {
    vnets_cidrs              = ["10.86.4.0/22"] #Per Wei's email
    aks_subnet_cidrs         = ["10.86.4.0/23"]
    location                 = ["westeurope"]
    rg_name                  = ["rg1"]
    nodepools = {
      apigeertime = {
        enable_auto_scaling  = true
        min_count            = 1
        max_count            = 2
        max_pods             = 30
        mode                 = "User"
        vm_size              = "Standard_F8s_v2"
        availability_zones   = ["1", "2", "3"]
      },
      apigeedata = {
        enable_auto_scaling  = true
        min_count            = 1
        max_count            = 2
        max_pods             = 30
        mode                 = "User"
        vm_size              = "Standard_F8s_v2"
        availability_zones   = ["1", "2", "3"]

      }
    }

    aks = { #TODO FIll in aks variables 
      dns_prefix             = "ah-aks"
      kubernetes_version     = "1.23.5"

      default_node_pool_name = "agentspool"
      min_count              = 2
      max_count              = 5
      max_pods               = 15
      enable_auto_scaling    = true
      vm_size                = "Standard_DS2_v2"

      #identity block
      identity_type = "SystemAssigned"
      availability_zones     = ["1", "2", "3"]
      #network_profile block
      load_balancer_sku      = "standard"
      network_plugin         = "azure"
      network_policy         = "calico"
      service_cidr           = "10.84.6.0/24"
      dns_service_ip         = "10.84.6.10"
      docker_bridge_cidrs    = "172.17.0.1/16"
    }

  }
  eastus2 = {
    vnets_cidrs              = ["10.84.4.0/22"] #Per Wei's email
    aks_subnet_cidrs         = ["10.84.4.0/23"]
    location                 = ["eastus2"]
    rg_name                  = ["rg1"]
    nodepools = {
      apigeertime = {
        enable_auto_scaling  = true
        min_count            = 1
        max_count            = 2
        max_pods             = 30
        mode                 = "User"
        vm_size              = "Standard_F8s_v2"
        availability_zones   = ["1", "2", "3"]
      },
      apigeedata = {
        enable_auto_scaling  = true
        min_count            = 1
        max_count            = 2
        max_pods             = 30
        mode                 = "User"
        vm_size              = "Standard_F8s_v2"
        availability_zones   = ["1", "2", "3"]

      }
    }

    aks = { #TODO FIll in aks variables 
      
      dns_prefix             = "ah-aks"
      kubernetes_version     = "1.23.5"

      default_node_pool_name = "agentspool"
      min_count              = 1
      max_count              = 2
      max_pods               = 30
      enable_auto_scaling    = true
      vm_size                = "Standard_DS2_v2"
      availability_zones     = ["1", "2", "3"]
      #identity block
      identity_type          = "SystemAssigned"

      #network_profile block
      load_balancer_sku      = "standard"
      network_plugin         = "azure"
      network_policy         = "calico"
      service_cidr           = "10.86.6.0/24"
      dns_service_ip         = "10.86.6.10"
      docker_bridge_cidrs    = "172.17.0.1/16"
    }

  }
}
