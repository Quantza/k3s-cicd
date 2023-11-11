# Existing resource made in 'prep' stage
data "harvester_network" "vm_network" {
    name = var.main-vlan.name
    namespace = var.main-vlan.namespace
}