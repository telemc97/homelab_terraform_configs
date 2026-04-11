terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.101.1"
    }
  }
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  count     = var.vms_amount
  name      = "${var.base_vm_name}-${count.index}"
  node_name = var.pm_node
  vm_id     = var.vm_id_start + count.index
  tags      = var.tags

  agent {
    enabled = false
  }

  cpu {
    cores = var.cpu_cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory_dedicated
    floating  = var.memory_dedicated
  }

  serial_device {}


  initialization {

    ip_config {
      ipv4 {
        address = "${var.ip_network_prefix}.${var.ip_address_start + count.index}/24"
        gateway = var.ip_gateway
      }
    }

    user_account {
      username = var.ci_username
      password = var.ci_password
      keys     = [var.ssh_ansible_public_key, var.ssh_auxilery_public_key]
    }

  }

  network_device {
    bridge = var.network_bridge
  }

  disk {
    datastore_id = var.datastore_id
    import_from  = "local:import/${var.disk_file_name}"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.disk_size
  }

}
