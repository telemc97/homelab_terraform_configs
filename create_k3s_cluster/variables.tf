variable "base_vm_name" {
    type = string
    description = "The base name for the cluster VMs."
}
variable "template_name" {
    type = string
    description = "The name of the template vm"
}
variable "tags" {
    type = set(string)
    description = "VM tags"
}
variable "vms_amount" {
    type = number
    description = "The amount of VMs to create."
}
variable "user_data_file_name" {
    type = string
    description = "The user data file for cloud init setup."
}

variable "disk_file_name" {
    type = string
    description = "The name of the disk file to import from the 'Import' section of Proxmox."
}

# Cloud init section
variable "ci_username" {
    type = string
    description = "Username for the created VMs"
}
variable "ci_password" {
    type = string
    description = "Passwords for the created VMs(The hash not the password)"
}
variable "ssh_ansible_public_key" {
    type = string
    description = "This is the public key to be used with ansible."
}
variable "ssh_auxilery_public_key" {
    type = string
    description = "This is an auxilery public key for testing purposes."
}