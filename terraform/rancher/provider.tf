terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "3.2.0"
    }
  }
}
provider "rancher2" {
  api_url    = var.rancher_api.url
  access_key = var.rancher_api.access_key
  secret_key = var.rancher_api.secret_key
  insecure = true
}