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

variable "vm-sshkey" {
    description = "Main VM ssh key"

    type = object({
        name = string
        namespace = string
        public_key = string
    })
    
    sensitive = true
}

# variable "cloud_config_user_data" {
#   description = "Cloud config user_data string for VM construction"
#   type = string
# }

# variable "cloud_config_user_data_docker" {
#   description = "Cloud config user_data string for VM construction"
#   type = string
# }