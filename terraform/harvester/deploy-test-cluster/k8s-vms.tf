resource "harvester_virtualmachine" "k8s-node" {
  for_each = {
    for vm in var.vms : vm.name => vm
  }

  name        = each.value.name
  namespace   = "default"
  description = each.value.desc
  cpu         = each.value.cores
  memory      = each.value.memory

  efi         = true
  secure_boot = true

  restart_after_update = true

  run_strategy    = "RerunOnFailure"
  hostname        = "${each.value.name}"
  reserved_memory = "100Mi"
  machine_type    = "q35"

  network_interface {
    name           = data.harvester_network.vm_network.name
    wait_for_lease = true
  }

  disk {
    name       = "rootdisk"
    type       = "disk"
    size       = "20Gi"
    bus        = "virtio"
    boot_order = 1

    image       = data.harvester_image.os-image.id
    auto_delete = true
  }
  
  dynamic "disk" {
    for_each = each.value.disk_size != "0G" ? [1] : []
    content {
      name        = "extradisk"
      type        = "disk"
      size        = "${each.value.disk_size}i"
      bus         = "virtio"
      auto_delete = true
    }
  }

  cloudinit {
    user_data_secret_name    = data.harvester_cloudinit_secret.cloud-config-main-ubuntu22-04.name
    network_data_secret_name = data.harvester_cloudinit_secret.cloud-config-main-ubuntu22-04.name
  }

  
}
