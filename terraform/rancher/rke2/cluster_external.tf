# rke2_cluster_external.tf
resource "rancher2_cluster_v2" "foo-harvester-v2" {
  name = "foo-harvester-v2"
  kubernetes_version = "v1.22.6+rke2r1"
  rke_config {
    machine_pools {
      name = "pool1"
      cloud_credential_secret_name = rancher2_cloud_credential.foo-harvester-external.id
      control_plane_role = true
      etcd_role = true
      worker_role = true
      quantity = 1
      machine_config {
        kind = rancher2_machine_config_v2.foo-harvester-v2.kind
        name = rancher2_machine_config_v2.foo-harvester-v2.name
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