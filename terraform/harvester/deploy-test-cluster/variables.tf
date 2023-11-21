variable "os-image" {
    description = "OS image for virtual machines"

    type = object({
        name = string
        namespace = string
        display_name = string
        description = string
        source_type = string
        url = string
        tags = map(string)
    })

    default = {
        name      = "os-image"
        namespace = "harvester-public"
        display_name = "os-image.img"
        description = ""
        source_type  = "download"
        url          = "https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-amd64.img"
        tags         = {"format"="img"}
    }
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
    mac_addr    = string
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