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
variable "ubuntu_cloud_image_url" {
    type = string
    description = "The cloud image url"
}
variable "ubuntu_cloud_image" {
    type = string
    description = "the cloud image disk file name"
}
