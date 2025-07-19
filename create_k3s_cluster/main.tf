resource "proxmox_vm_qemu" "k3s_cluster" {
  count       = var.vms_amount
  name        = "${var.base_vm_name}-${count.index}"
  target_node = var.pm_node
  clone       = var.template_name
  full_clone  = true
  vmid        = 300 + count.index
  tags        = "terraform_created"

  cicustom   = var.user_data_file_path
  ipconfig0 = "ip=192.168.1.${100 + count.index}/24,gw=192.168.1.1"

  lifecycle {
    ignore_changes = [ network ]
  }

}