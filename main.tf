module "k3s_cluster" {
  source = "./create_k3s_cluster"

  pm_node = var.pm_node

  # Cluster configuration object
  config = var.k3s_config

  # Credentials (passed separately for security/flexibility)
  ci_username             = var.ci_username
  ci_password             = var.ci_password
  ssh_ansible_public_key  = var.ssh_ansible_public_key
  ssh_auxilery_public_key = var.ssh_auxilery_public_key
}
