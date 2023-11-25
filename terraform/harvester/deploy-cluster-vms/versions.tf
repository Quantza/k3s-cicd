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
    kubeconfig = "${path.root}/mission-ctrl-hrv-kubeconfig.yaml"
}