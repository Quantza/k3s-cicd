variable "proxmox_api" {
    description = "API key for Proxmox Cluster"

    type = object({
        access_key = string
        secret_key = string
        url = string
    })

    sensitive = true
}

variable "vm_user" {
    type = string
    description = "Main VM user"
    
    sensitive = true
}

variable "gateway_ip" {
  type        = string
  description = "IP of gateway"
  default     = "<IP address>"
}

variable "vms" {
  type = list(object({
    name        = string
    target_node = string
    desc        = string
    ip          = string
    memory      = number
    cores       = number
    sockets     = number
    disk_size   = string
    vmid        = string
  }))
  default = []
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