terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.84.1"
    }
  }
}

provider "proxmox" {
  endpoint = var.pm_api_endpoint
  api_token = var.pm_api_token
  insecure = true
}