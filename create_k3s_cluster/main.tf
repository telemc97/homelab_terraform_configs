resource "proxmox_vm_qemu" "template_vm" {
  count       = var.vms_amount
  name        = "${var.base_vm_name}-${count.index}"
  target_node = var.pm_node
  clone_id    = var.template_vm_id
  full_clone  = true
  vmid        = 300 + count.index

  cicustom   = var.user_data_file_path

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.1.${100 + count.index}/24,gw=192.168.1.1"

}
