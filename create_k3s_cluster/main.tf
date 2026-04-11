terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.101.1"
    }
  }
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  count     = var.config.vms_amount
  name      = "${var.config.base_vm_name}-${count.index}"
  node_name = var.pm_node
  vm_id     = var.config.vm_id_start + count.index
  tags      = var.config.tags

  agent {
    enabled = false
  }

  cpu {
    cores = var.config.cpu_cores
    type  = var.config.cpu_type
  }

  memory {
    dedicated = var.config.memory_dedicated
    floating  = var.config.memory_dedicated
  }

  serial_device {}


  initialization {

    ip_config {
      ipv4 {
        address = "${var.config.ip_network_prefix}.${var.config.ip_address_start + count.index}/24"
        gateway = var.config.ip_gateway
      }
    }

    user_account {
      username = var.ci_username
      password = var.ci_password
      keys     = [var.ssh_ansible_public_key, var.ssh_auxilery_public_key]
    }

  }

  network_device {
    bridge = var.config.network_bridge
  }

  disk {
    datastore_id = var.config.datastore_id
    import_from  = "local:import/${var.config.disk_file_name}"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.config.disk_size
  }

}
