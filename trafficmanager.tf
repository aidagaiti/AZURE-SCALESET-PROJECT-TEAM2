resource "azurerm_resource_group" "project1" {
  name     = "trafficmanagerendpointTest"
  location = "West Europe"
}

resource "azurerm_traffic_manager_profile" "demo" {
  name                = "demotm"
  resource_group_name = azurerm_resource_group.project1.name

  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = "demotm"
    ttl           = 100
  }

  monitor_config {
    protocol                     = "http"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_traffic_manager_endpoint" "example" {
  name                = "demotm"
  resource_group_name = azurerm_resource_group.project1.name
  profile_name        = azurerm_traffic_manager_profile.demo.name
  target              = "terraform.io"
  type                = "externalEndpoints"
  weight              = 100
}