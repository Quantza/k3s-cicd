resource "harvester_image" "os-image" {
  name          = var.os-image.name
  namespace     = var.os-image.namespace
  display_name  = var.os-image.display_name
  source_type   = var.os-image.source_type
  url           = var.os-image.url
  tags          = var.os-image.tags
}

resource "harvester_image" "ubuntu22-04" {
  name      = "ubuntu22-04"
  namespace = "harvester-public"

  display_name = "ubuntu-22.04-server-cloudimg-amd64.img"
  source_type  = "download"
  url          = "https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-amd64.img"
}

resource "harvester_image" "ubuntu20-04" {
  name      = "ubuntu20-04"
  namespace = "harvester-public"

  display_name = "ubuntu-20.04-server-cloudimg-amd64.img"
  source_type  = "download"
  url          = "http://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
}