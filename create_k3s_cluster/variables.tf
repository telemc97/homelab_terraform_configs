variable "pm_node" {
  type        = string
  description = "The Proxmox node to create the vms"
}

variable "config" {
  type = object({
    base_vm_name      = string
    vms_amount        = number
    disk_file_name    = string
    tags              = optional(set(string), ["terraform_created"])
    vm_id_start       = optional(number, 300)
    cpu_cores         = optional(number, 2)
    cpu_type          = optional(string, "x86-64-v2-AES")
    memory_dedicated  = optional(number, 2048)
    ip_address_start  = optional(number, 200)
    ip_network_prefix = optional(string, "192.168.1")
    ip_gateway        = optional(string, "192.168.1.1")
    network_bridge    = optional(string, "vmbr0")
    datastore_id      = optional(string, "local-lvm")
    disk_size         = optional(number, 10)
  })
  description = "Configuration for the cluster nodes"
}

# Cloud init section
variable "ci_username" {
  type        = string
  description = "Username for the created VMs"
}
variable "ci_password" {
  type        = string
  description = "Passwords for the created VMs(The hash not the password)"
}
variable "ssh_ansible_public_key" {
  type        = string
  description = "This is the public key to be used with ansible."
}
variable "ssh_auxilery_public_key" {
  type        = string
  description = "This is an auxilery public key for testing purposes."
}
