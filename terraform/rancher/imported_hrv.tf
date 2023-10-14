data "rancher2_cluster_v2" "mission-ctrl-hrv-imported" {
  name = "mission-ctrl-hrv-imported"
}
resource "rancher2_cloud_credential" "mission-ctrl-hrv-imported-creds" {
  name = "mission-ctrl-hrv-imported-creds"
  harvester_credential_config {
    cluster_id = data.rancher2_cluster_v2.mission-ctrl-hrv-imported.cluster_v1_id
    cluster_type = "imported"
    kubeconfig_content = data.rancher2_cluster_v2.mission-ctrl-hrv-imported.kube_config
  }
}