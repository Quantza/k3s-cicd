variable "cluster_def" {
  type = object({

    cluster_name = string
    k8s_version = string
    fleet_namespace = string
    machine_global_config = string
    
    node_type_vars = list(object({
        name = string
        control_plane_role = bool
        etcd_role = bool
        worker_role = bool
        quantity = number
        drain_before_delete = bool
    }))
    
  })
}

variable "hrv_api" {
    description = "API key for Harvester Cluster"

    type = object({
        access_key = string
        secret_key = string
    })

    sensitive = true
}

variable "rancher_api" {
    description = "API key for Rancher Mgmt. Cluster"

    type = object({
        access_key = string
        secret_key = string
        url = string
    })

    sensitive = true
}

variable "cloud_init_template" {
  type        = string
  description = "Name of the cloud-init template to use"
  default     = "ubuntu-2204-cloudinit-template"
}

variable "cloud-config-main-ubuntu22-04" {

    type = object({
      name = string
      namespace = string
      vm-sshkey = string
    })

    sensitive = true
}

variable "vm_os-image" {
    description = "Main VM OS image"

    type = object({
        id = string
        namespace = string
    })

    default = {
        id = "os-image"
        namespace = "harvester-public"
    }
}

variable "main-vlan" {
    description = "VLAN for trusted virtual machine service interfaces"

    type = object({
        id = number
        name = string
        namespace = string
    })

    default = {
        id = "1"
        name = "main-vlan"
        namespace = "default"
    }
}

variable "mgmt-vlan" {
    description = "Management VLAN"

    type = object({
        id = number
        name = string
        namespace = string
    })
    
    sensitive = true
}

variable "untrusted-vlan" {
    description = "VLAN for untrusted virtual machine service interfaces"

    type = object({
        id = number
        name = string
        namespace = string
    })
    
    sensitive = true
}