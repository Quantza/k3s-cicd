data "rancher2_cluster_v2" "mission-ctrl-harvester-imported" {
  name = "mission-ctrl-harvester-imported"
}
resource "rancher2_cloud_credential" "mission-ctrl" {
  name = "mission-ctrl-harvester-imported"
  harvester_credential_config {
    cluster_id = data.rancher2_cluster_v2.mission-ctrl-harvester-imported.cluster_v1_id
    cluster_type = "imported"
    kubeconfig_content = data.rancher2_cluster_v2.mission-ctrl-harvester-imported.kube_config
  }
}