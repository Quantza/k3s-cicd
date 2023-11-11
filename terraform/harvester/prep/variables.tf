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
