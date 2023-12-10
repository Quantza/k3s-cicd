data "harvester_cloudinit_secret" "cloud-config-docker-ubuntu22-04" {
  name      = "cloud-config-docker-ubuntu22-04"
  namespace = "default"
}

data "harvester_cloudinit_secret" "cloud-config-main-ubuntu22-04" {
  name      = "cloud-config-ubuntu22-04"
  namespace = "default"
}