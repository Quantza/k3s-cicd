resource "rancher2_cloud_credential" "mission-ctrl-harvester-external-creds" {
  name = "mission-ctrl-harvester-external-creds"
  description = "cloudCredentials for 'mission-ctrl' Harvester cluster"
  harvester_credential_config {
    cluster_type = "external"
    kubeconfig_content = file("$HOME/.kube/mission-ctrl-harvester-kubeconfig.yaml")
  }
}