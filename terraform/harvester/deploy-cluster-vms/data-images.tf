data "harvester_image" "os-image" {
  name          = var.os-image.name
  namespace     = var.os-image.namespace
}