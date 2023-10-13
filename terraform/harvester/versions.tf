terraform {
  required_version = ">= 0.13"
  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = "0.6.3"
    }
  }
}

provider "harvester" {
    # Provide full path
    kubeconfig = var.harvester_kubeconfig_path
}