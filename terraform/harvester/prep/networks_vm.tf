# Use 'data' block for an existing network.
# Use 'resource' block for a new one.

resource "harvester_network" "mgmt-vlan" {
  vlan_id   = var.mgmt-vlan.id
  name      = var.mgmt-vlan.name
  namespace = var.mgmt-vlan.namespace

  route_mode = "auto"
  route_dhcp_server_ip = ""

  cluster_network_name = data.harvester_clusternetwork.mgmt.name
}

resource "harvester_network" "main-vlan" {
  vlan_id   = var.main-vlan.id
  name      = var.main-vlan.name
  namespace = var.main-vlan.namespace

  route_mode = "auto"
  route_dhcp_server_ip = ""

  cluster_network_name = data.harvester_clusternetwork.mgmt.name
}

resource "harvester_network" "untrusted-vlan" {
  vlan_id   = var.untrusted-vlan.id
  name      = var.untrusted-vlan.name
  namespace = var.untrusted-vlan.namespace

  cluster_network_name = data.harvester_clusternetwork.mgmt.name
}