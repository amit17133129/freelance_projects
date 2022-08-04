# Terraform resource to create AKS Cluster.
resource "azurerm_kubernetes_cluster" "aks" {
  for_each            = var.aks_clusters
  name                = "aks-${var.environment == "prod" ? "prod" : "dev"}-${each.key}-01"
  location            = each.key #var.aks_cluster_locations[terraform.workspace][count.index]
  resource_group_name = azurerm_resource_group.azurerg[each.key].name #azurerm_resource_group.azurerg.name
  dns_prefix          = each.value.aks.dns_prefix
  kubernetes_version  = each.value.aks.kubernetes_version # This version is compatible with Apigee Hybrid 1.7.2


  default_node_pool {
    name                = each.value.aks.default_node_pool_name
    min_count           = each.value.aks.min_count
    max_count           = each.value.aks.max_count
    max_pods            = each.value.aks.max_pods
    enable_auto_scaling = each.value.aks.enable_auto_scaling
    vm_size             = each.value.aks.vm_size
    # The subnet into which both the nodes and containers in the cluster will be placed.
    vnet_subnet_id      = azurerm_subnet.aks-ah-cluster-subnets[each.key].id
    availability_zones  = each.value.aks.availability_zones
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = each.value.aks.load_balancer_sku
    network_plugin    = each.value.aks.network_plugin
    network_policy    = each.value.aks.network_policy

    # A CIDR notation IP range from which to assign service cluster IPs. It must not overlap with any Subnet IP ranges. For example: 10.0.0.0/16.
    service_cidr = each.value.aks.service_cidr
    # An IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range. For example: 10.0.0.10
    dns_service_ip = each.value.aks.dns_service_ip
    # An IP address and netmask assigned to Docker Bridge. It must not be in any Subnet IP ranges, or the Kubernetes service address range. For example: 172.17.0.1/16.
    docker_bridge_cidr = each.value.aks.docker_bridge_cidrs
  }

  tags = {
    Environment = "Development"
  }
}
