resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  count     = var.vms_amount
  name      = "${var.base_vm_name}-${count.index}"
  node_name = var.pm_node
  vm_id     = 300 + count.index
  tags      = var.tags

  agent {
    enabled = false
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"  # recommended for modern CPUs
  }

  memory {
    dedicated = 2048
    floating  = 2048
  }

  serial_device {}


  initialization {

    ip_config {
      ipv4 {
        address = "192.168.1.${200 + count.index}/24"
        gateway = "192.168.1.1"
      }
    }

    user_account {
      username = var.ci_username
      password = var.ci_password
      keys     = [var.ssh_ansible_public_key, var.ssh_auxilery_public_key]
    }

  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-lvm"
    import_from  = "local:import/${var.disk_file_name}"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 10
  }
  
}