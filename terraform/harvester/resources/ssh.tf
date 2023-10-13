resource "harvester_ssh_key" "vm_ssh_key" {
  name      = var.vm_ssh_key.name
  namespace = var.vm_ssh_key.namespace
}
