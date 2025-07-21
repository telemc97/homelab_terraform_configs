resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  count     = var.vms_amount
  name      = "${var.base_vm_name}-${count.index}"
  node_name = var.pm_node
  vm_id     = 300 + count.index
  tags      =  var.tags
  # should be true if qemu agent is not installed / enabled on the VM
  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"  # recommended for modern CPUs
  }

  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }

  serial_device {}


  initialization {
    ip_config {
      ipv4 {
        address = "192.168.1.${100 + count.index}/24"
        gateway = "192.168.1.1"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.user_data.id

  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-lvm"
    import_from  = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }
  
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = var.pm_node
  url          = var.ubuntu_cloud_image_url
  file_name    = var.ubuntu_cloud_image
}

resource "proxmox_virtual_environment_file" "user_data" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.pm_node

  source_raw {
    data = templatefile("${path.module}/cloud_config.tpl", {
      ci_username                  = var.ci_username
      ci_password                  = var.ci_password
      ssh_key_0                    = var.ssh_key_0
      ssh_key_1                    = var.ssh_key_1
    })

    file_name = "user_data.yaml"
  }
}