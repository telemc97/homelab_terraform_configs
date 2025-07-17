variable "base_vm_name" {
    type = string
    description = "The base name for the cluster VMs."
}
variable "template_vm_id" {
    type = number
    description = "The ID of the template vm"
}
variable "vms_amount" {
    type = number
    description = "The amount of VMs to create."
}
variable "storage_pool" {
    type = string
    description = "The storage on which the vm disks are stored."
}
variable "user_data_file_path" {
    type = string
    description = "The path that the cloud-init file is stored."
}
