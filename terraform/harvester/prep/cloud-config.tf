resource "harvester_cloudinit_secret" "cloud-config-docker-ubuntu22-04" {
  name      = "cloud-config-docker-ubuntu22-04"
  namespace = "default"

  depends_on = [
    harvester_ssh_key.vm-sshkey
  ]

  user_data    = <<EOF
#cloud-config
users:
  - name: quantza
    sudo: ALL=(ALL) NOPASSWD:ALL
    passwd: $6$tCgT7xBA.tJf62Mf$Lo7mC7QynUVu0b3CcQR0GP2ELOaNivVCCcWXwtR44SyDuf/MlpoHXimCMoRy1Dq4m7lpCeQy4Q1vaO//Z6wkx0
    ssh_authorized_keys:
      - >-
        public_key content of harvester_ssh_key.vm-sshkey
    lock_passwd: false
    shell: /bin/bash

packages:
  - curl
  - wget
  - btop

write_files:
  - path: /tmp/install_docker.sh
content: |
    #!/bin/bash
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    permissions: '0755'

runcmd:
  - sudo apt update && sudo apt upgrade -y
  - sudo /tmp/install_docker.sh
  - - systemctl
    - enable
    - '--now'
    - qemu-guest-agent
EOF
  network_data = ""
}

resource "harvester_cloudinit_secret" "cloud-config-main-ubuntu22-04" {
  name      = "cloud-config-ubuntu22-04"
  namespace = "default"

  depends_on = [
    harvester_ssh_key.vm-sshkey
  ]

  user_data    = <<EOF
#cloud-config
users:
  - name: quantza
    sudo: ALL=(ALL) NOPASSWD:ALL
    passwd: $6$tCgT7xBA.tJf62Mf$Lo7mC7QynUVu0b3CcQR0GP2ELOaNivVCCcWXwtR44SyDuf/MlpoHXimCMoRy1Dq4m7lpCeQy4Q1vaO//Z6wkx0
    ssh_authorized_keys:
      - >-
        public_key content of harvester_ssh_key.vm-sshkey
    lock_passwd: false
    shell: /bin/bash
package_update: true
packages:
  - qemu-guest-agent
  - curl
  - wget
  - btop
runcmd:
  - - systemctl
    - enable
    - '--now'
    - qemu-guest-agent.service
EOF
  network_data = ""
}