resource "rancher2_machine_config_v2" "foo-harvester-v2" {
  generate_name = "foo-harvester-v2"
  harvester_config {
    vm_namespace = "default"
    cpu_count = "2"
    memory_size = "4"
    disk_size = "10"
    network_name = "default/vlan1"
    image_name = "default/<Harvester_Downloaded_CloudImage_ID>"
    ssh_user = "ubuntu"
  }
}