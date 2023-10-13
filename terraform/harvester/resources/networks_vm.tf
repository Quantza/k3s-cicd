# Use 'data' block for an existing network.
# Use 'resource' block for a new one.

resource "harvester_network" "default-vlan" {
  name      = var.default-vlan.vlanid
  namespace = var.default-vlan.namespace
}

resource "harvester_network" "main-vlan" {
  name      = var.main-vlan.vlanid
  namespace = var.main-vlan.namespace
}

resource "harvester_network" "untrusted-vlan" {
  name      = var.untrusted-vlan.vlanid
  namespace = var.untrusted-vlan.namespace
}