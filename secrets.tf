variable "pm_api_endpoint" {
  type        = string
  description = "Proxmox API URL"
}

variable "pm_api_token" {
  type        = string
  description = "Proxmox API token id"
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