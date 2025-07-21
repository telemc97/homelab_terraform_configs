#cloud-config
users:
  - name: ${ci_username}
    passwd: ${ci_password}
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, sudo
    shell: /bin/bash
    ssh_authorized_keys:
      - ${ssh_key_0}
      - ${ssh_key_1}

chpasswd:
  expire: false

packages:
  - qemu-guest-agent
  - openssh-server
  - linux-generic-hwe-22.04

package_update: true
package_upgrade: true
package_reboot_if_required: true

runcmd:
  - [ systemctl, daemon-reload ]
  - [ systemctl, enable, qemu-guest-agent.service ]
  - [ systemctl, start, --no-block, qemu-guest-agent.service ]
