resource "rancher2_machine_config_v2" "mission-ctrl-hrv-etcd-v2" {
  generate_name = "mission-ctrl-hrv-etcd-v2"
  harvester_config {
    vm_namespace = "default"
    cpu_count = "2"
    memory_size = "4"
    disk_info = <<EOF
    {
        "disks": [{
            "name": "rootdisk",
            "imageName": "${var.vm_os_image.namespace}/${var.vm_os_image.id}",
            "size": 32,
            "bootOrder": 1
        }]
    }
    EOF
    network_info = <<EOF
    {
        "interfaces": [{
            "networkName": "${var.default-vlan.namespace}/${var.default-vlan.vlanid}"
        }]
    }
    EOF
    ssh_user = var.vm_user.name
    user_data = var.cloud-config-main-ubuntu22.04
  }
}

resource "rancher2_machine_config_v2" "mission-ctrl-hrv-cplane-v2" {
  generate_name = "mission-ctrl-hrv-cplane-v2"
  harvester_config {
    vm_namespace = "default"
    cpu_count = "2"
    memory_size = "6"
    disk_info = <<EOF
    {
        "disks": [{
            "name": "rootdisk",
            "imageName": "${var.vm_os_image.namespace}/${var.vm_os_image.id}",
            "size": 20,
            "bootOrder": 1
        }]
    }
    EOF
    network_info = <<EOF
    {
        "interfaces": [{
            "networkName": "${var.default-vlan.namespace}/${var.default-vlan.vlanid}"
        }]
    }
    EOF
    ssh_user = var.vm_user.name
    user_data = var.cloud-config-main-ubuntu22.04
  }
}

resource "rancher2_machine_config_v2" "mission-ctrl-hrv-wrkr-v2" {
  generate_name = "mission-ctrl-hrv-wrkr-v2"
  harvester_config {
    vm_namespace = "default"
    cpu_count = "2"
    memory_size = "6"
    disk_info = <<EOF
    {
        "disks": [{
            "name": "rootdisk",
            "imageName": "${var.vm_os_image.namespace}/${var.vm_os_image.id}",
            "size": 64,
            "bootOrder": 1
        },
        {
            "name": "extradisk",
            "size": 16,
            "bootOrder": 2
        }]
    }
    EOF
    network_info = <<EOF
    {
        "interfaces": [{
            "networkName": "${var.default-vlan.namespace}/${var.default-vlan.vlanid}"
        }]
    }
    EOF
    ssh_user = var.vm_user.name
    user_data = var.cloud-config-main-ubuntu22.04
  }
}