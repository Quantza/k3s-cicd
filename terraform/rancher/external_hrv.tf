resource "rancher2_cloud_credential" "mission-ctrl-hrv-external-creds" {
  name = "mission-ctrl-hrv-external-creds"
  description = "cloudCredentials for 'mission-ctrl' Harvester cluster"
  harvester_credential_config {
    cluster_type = "external"
    kubeconfig_content = file("$HOME/.kube/mission-ctrl-hrv-kubeconfig.yaml")
  }
}