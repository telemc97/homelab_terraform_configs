variable "pm_node" {
  type        = string
  description = "The Proxmox node to create the vms"
}

variable "base_vm_name" {
  type        = string
  description = "The base name for the cluster VMs."
}
variable "tags" {
  type        = set(string)
  description = "VM tags"
}
variable "vms_amount" {
  type        = number
  description = "The amount of VMs to create."
}

variable "disk_file_name" {
  type        = string
  description = "The name of the disk file to import from the 'Import' section of Proxmox."
}

variable "vm_id_start" {
  type        = number
  description = "The starting VM ID for the cluster."
  default     = 300
}

variable "cpu_cores" {
  type        = number
  description = "The number of CPU cores for each VM."
  default     = 2
}

variable "cpu_type" {
  type        = string
  description = "The CPU type for each VM."
  default     = "x86-64-v2-AES"
}

variable "memory_dedicated" {
  type        = number
  description = "The dedicated memory for each VM in MB."
  default     = 2048
}

variable "ip_address_start" {
  type        = number
  description = "The starting last octet for the static IP addresses."
  default     = 200
}

variable "ip_network_prefix" {
  type        = string
  description = "The network prefix for the static IP addresses (e.g., 192.168.1)."
  default     = "192.168.1"
}

variable "ip_gateway" {
  type        = string
  description = "The gateway IP address for the VMs."
  default     = "192.168.1.1"
}

variable "network_bridge" {
  type        = string
  description = "The network bridge to attach the VMs to."
  default     = "vmbr0"
}

variable "datastore_id" {
  type        = string
  description = "The Proxmox datastore ID for the VM disks."
  default     = "local-lvm"
}

variable "disk_size" {
  type        = number
  description = "The disk size for each VM in GB."
  default     = 10
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