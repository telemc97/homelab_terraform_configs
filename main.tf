module "k3s_cluster" {
  source = "./create_k3s_cluster"

  pm_node                 = var.pm_node
  base_vm_name            = var.base_vm_name
  template_name           = var.template_name
  tags                    = var.tags
  vms_amount              = var.vms_amount
  disk_file_name          = var.disk_file_name
  user_data_file_name     = var.user_data_file_name
  ci_username             = var.ci_username
  ci_password             = var.ci_password
  ssh_ansible_public_key  = var.ssh_ansible_public_key
  ssh_auxilery_public_key = var.ssh_auxilery_public_key
}
