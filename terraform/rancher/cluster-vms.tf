resource "rancher2_machine_config_v2" "k8s-node" {

  for_each = {
    for vm in var.vms : vm.name => vm
  }

  generate_name = each.value.name
  harvester_config {
    # "default"
    vm_namespace = each.value.namespace

    cpu_count = "${each.value.sockets * each.value.cores}"
    memory_size = "${each.value.memory}Mi"
    disk_info = <<EOF
{
    "disks": [{
        "name": "rootdisk",
        "imageName": "${var.vm_os-image.namespace}/${var.vm_os-image.id}",
        "size": 20,
        "bootOrder": 1
    },
    {
        "name": "extradisk",
        "storageClassName": "${each.value.disk_source}",
        "size": "${each.value.disk_size}",
        "bootOrder": 2
    }]
}
EOF
    network_info = <<EOF
{
    "interfaces": [{
        "networkName": "${var.main-vlan.namespace}/${var.main-vlan.name}",
        "macAddress": ${each.value.mac_addr != "" ? each.value.mac_addr : null},
        "type": "bridge",
        "waitForLease": true
    }]
}
EOF
    ssh_user = var.vm_user
    user_data = var.cloud-config-main-ubuntu22-04.user_data
  }
}