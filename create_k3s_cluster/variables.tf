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

# Cloud image section
variable "ubuntu_cloud_image_url" {
    type = string
    description = "The cloud image url"
}
variable "ubuntu_cloud_image" {
    type = string
    description = "the cloud image disk file name"
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
variable "ssh_key_0" {
    type = string
    description = "ssh public key"
}
variable "ssh_key_1" {
    type = string
    description = "ssh public key"
}