resource "rancher2_cluster_v2" "k8s-clstr" {
  name = var.cluster_def.cluster_name
  fleet_namespace = var.cluster_def.fleet_namespace != "" ? var.cluster_def.fleet_namespace : null
  kubernetes_version = {{ var.cluster_def.k8s_version }}
  rke_config {

    dynamic "machine_pools" {

      for_each = {
        for node_type_vars in var.cluster_def.node_type_vars : node_type_vars.name => node_type_vars
      }
      
      content {
        name = machine_pools.value.name
        cloud_credential_secret_name = rancher2_cloud_credential.mission-ctrl-hrv-external-creds.id
        control_plane_role = machine_pools.value.control_plane_role
        etcd_role = machine_pools.value.etcd_role
        worker_role = machine_pools.value.worker_role
        quantity = machine_pools.value.quantity
        drain_before_delete = machine_pools.value.drain_before_delete

        machine_config {
          kind = rancher2_machine_config_v2.{{ machine_pools.value.name }}.kind
          name = rancher2_machine_config_v2.{{ machine_pools.value.name }}.name
        }
      }

    }

    machine_global_config = var.cluster_def.machine_global_config
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