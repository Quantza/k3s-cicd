resource "harvester_ssh_key" "vm-sshkey" {
  name        = var.vm-sshkey.name
  namespace   = var.vm-sshkey.namespace
  public_key  = var.vm-sshkey.public_key
}
