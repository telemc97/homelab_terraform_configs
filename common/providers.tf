terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.80.0"
    }
  }
}

provider "proxmox" {
  endpoint = var.pm_api_endpoint
  api_token = var.pm_api_token
  insecure = true
  ssh {
    agent = false
    username = var.terraform_ssh_user
    private_key = var.terraform_ssh_private_key
  }
}