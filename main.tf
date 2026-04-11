module "k3s_cluster" {
  source = "./create_k3s_cluster"

  pm_node                 = var.pm_node
  base_vm_name            = var.base_vm_name
  tags                    = var.tags
  vms_amount              = var.vms_amount
  disk_file_name          = var.disk_file_name
  ci_username             = var.ci_username
  ci_password             = var.ci_password
  ssh_ansible_public_key  = var.ssh_ansible_public_key
  ssh_auxilery_public_key = var.ssh_auxilery_public_key

  # Optional flexibility variables
  vm_id_start       = var.vm_id_start
  cpu_cores         = var.cpu_cores
  cpu_type          = var.cpu_type
  memory_dedicated  = var.memory_dedicated
  ip_address_start  = var.ip_address_start
  ip_network_prefix = var.ip_network_prefix
  ip_gateway        = var.ip_gateway
  network_bridge    = var.network_bridge
  datastore_id      = var.datastore_id
  disk_size         = var.disk_size
}
