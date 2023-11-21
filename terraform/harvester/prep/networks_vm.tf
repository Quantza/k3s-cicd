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

  route_mode = "auto"
  route_dhcp_server_ip = ""

  cluster_network_name = data.harvester_clusternetwork.mgmt.name
}

# resource "harvester_network" "cluster-vlan" {
#   for_each  = toset(["2", "3"])
#   name      = "cluster-vlan${each.key}"
#   namespace = "harvester-public"

#   vlan_id = each.key

#   route_mode    = "manual"
#   route_cidr    = "10.34.0.1/24"
#   route_gateway = "10.34.0.1"

#   cluster_network_name = harvester_clusternetwork.cluster-vlan.name
#   depends_on = [
#     harveterraform/harvesterster_clusternetwork.cluster-vlan
#   ]
# }
