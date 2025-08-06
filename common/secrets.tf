variable "pm_api_endpoint" {
    type = string
    description = "Proxmox API URL"
}
variable "pm_api_token" {
    type = string
    description = "Proxmox API token id"
}
variable "private_key" {
    type = string
    description = "The private ssh key for use by terraform"
}