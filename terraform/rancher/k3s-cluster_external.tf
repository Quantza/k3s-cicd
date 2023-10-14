# rke2_cluster_external.tf
resource "rancher2_cluster_v2" "mission-ctrl-hrv" {
  name = "mission-ctrl-hrv"
  fleet_namespace = "fleet-mission-ctrl"
  kubernetes_version = "v1.26.8+k3s1"
  rke_config {
    machine_pools {
      name = "mission-ctrl-hrv-etcd"
      cloud_credential_secret_name = rancher2_cloud_credential.mission-ctrl-hrv-external-creds.id
      control_plane_role = false
      etcd_role = true
      worker_role = false
      quantity = 3
      drain_before_delete = true
      machine_config {
        kind = rancher2_machine_config_v2.mission-ctrl-hrv-etcd-v2.kind
        name = rancher2_machine_config_v2.mission-ctrl-hrv-etcd-v2.name
      }
    }
    machine_pools {
      name = "mission-ctrl-hrv-cplane"
      cloud_credential_secret_name = rancher2_cloud_credential.mission-ctrl-hrv-external-creds.id
      control_plane_role = true
      etcd_role = false
      worker_role = false
      quantity = 2
      drain_before_delete = true
      machine_config {
        kind = rancher2_machine_config_v2.mission-ctrl-hrv-cplane-v2.kind
        name = rancher2_machine_config_v2.mission-ctrl-hrv-cplane-v2.name
      }
    }
    machine_pools {
      name = "mission-ctrl-hrv-wrkr"
      cloud_credential_secret_name = rancher2_cloud_credential.mission-ctrl-hrv-external-creds.id
      control_plane_role = false
      etcd_role = false
      worker_role = true
      quantity = 3
      drain_before_delete = true
      machine_config {
        kind = rancher2_machine_config_v2.mission-ctrl-hrv-wrkr-v2.kind
        name = rancher2_machine_config_v2.mission-ctrl-hrv-wrkr-v2.name
      }
    }
    machine_selector_config {
      config = {
        cloud-provider-name = ""
      }
    }
    machine_global_config = <<EOF
cni: "calico"
disable-kube-proxy: false
etcd-expose-metrics: false
EOF
    upgrade_strategy {
      control_plane_concurrency = "10%"
      worker_concurrency = "10%"
    }
    etcd {
      snapshot_schedule_cron = "0 */5 * * *"
      snapshot_retention = 5
    }
    chart_values = ""
  }
}