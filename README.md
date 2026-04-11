# Homelab Terraform Configurations

Automated infrastructure provisioning for a Proxmox-based homelab environment using Terraform.

## Project Overview

This repository provides a modular Terraform setup to deploy and manage virtual machines on Proxmox VE. It is specifically optimized for creating **k3s (Lightweight Kubernetes)** cluster nodes with automated Cloud-Init configuration.

### Key Features
- **Native Terraform Modules**: Clean separation between orchestration and resource definitions.
- **Proxmox Integration**: Uses the `bpg/proxmox` provider for modern API interactions.
- **Automated Provisioning**: Cloud-Init support for user accounts, SSH keys, and network configuration.
- **Flexible & Scalable**: Uses configuration objects to minimize boilerplate and simplify cluster management.

---

## Project Structure

```text
.
├── main.tf                # Root orchestrator (calls modules)
├── variables.tf           # Root variable declarations (uses objects)
├── providers.tf           # Proxmox provider configuration
├── secrets.tf             # Sensitive variable declarations (API keys, etc.)
├── terraform.tfvars       # Main configuration values (ignored by git)
├── GEMINI.md              # Detailed technical context for AI assistants
└── create_k3s_cluster/    # Module: k3s Node Provisioning
    ├── main.tf            # VM resource definitions
    └── variables.tf       # Module-specific input variables
```

---

## Getting Started

### 1. Prerequisites
- **Proxmox VE**: A running Proxmox host with API access enabled.
- **Terraform**: Version 1.5.0 or higher.
- **Cloud Image**: An Ubuntu (or similar) `.qcow2` cloud image uploaded to your Proxmox `import` datastore.

---

## Proxmox Side Preparation

Before running Terraform, ensure the following steps are completed on your Proxmox VE host:

### 1. API Token Creation
1. Go to **Datacenter > Permissions > API Tokens**.
2. Click **Add** and select your user (e.g., `root@pam` or a dedicated terraform user).
3. Uncheck **Privilege Separation** for ease of use, or ensure the token has the necessary roles (e.g., `Administrator` or a custom role with `PVEVMAdmin`, `PVEDatastoreAdmin`, `PVENetworkAdmin`).
4. **Important**: Save the Secret ID and Secret Key immediately; you won't be able to see the key again.

### 2. Cloud Image Upload
The Terraform configuration uses the `import_from` feature to clone the VM disk from a `.qcow2` image.
1. Download a Cloud-Init compatible image (e.g., [Ubuntu Cloud Images](https://cloud-images.ubuntu.com/)).
2. Select your storage (e.g., `local`) in the Proxmox UI.
3. Select the **ISO Images** or **Import** section (depending on your Proxmox version).
4. Upload the `.qcow2` file.
5. The default configuration expects the file to be accessible via `local:import/<filename>`.

### 3. API Endpoint
Ensure your API endpoint is accessible from your local machine. Usually, it follows the format: `https://<PROXMOX_IP>:8006/api2/json`.

---

### 2. Configuration
Create a `terraform.tfvars` file in the root directory and provide your environment details. Note that sensitive credentials (API tokens, passwords, and SSH keys) are declared in `secrets.tf`, while general configuration is in `variables.tf`.

```hcl
# Proxmox Connection
pm_api_endpoint = "https://192.168.1.10:8006/api2/json"
pm_api_token    = "user@pve!token-id=uuid"
pm_node         = "pve-01"

# Cluster Configuration
k3s_config = {
  base_vm_name   = "k3s-node"
  vms_amount     = 3
  disk_file_name = "ubuntu-24.04-server-cloudimg-amd64.qcow2"
  tags           = ["terraform", "k3s"]

  # Optional Hardware/Network overrides (Defaults will be used if omitted)
  # cpu_cores        = 4
  # memory_dedicated = 4096
  # ip_address_start  = 100
}

# Cloud-Init
ci_username             = "admin"
ci_password             = "$6$rounds=4096$..." # SHA-512 hashed password
ssh_ansible_public_key  = "ssh-ed25519 ..."
ssh_auxilery_public_key = "ssh-ed25519 ..."
```

### Required Connection Fields

| Variable | Description |
| :--- | :--- |
| `pm_api_endpoint` | The full Proxmox API URL (including `/api2/json`). |
| `pm_api_token` | The Proxmox API Token ID and Secret in the format `user@pve!token_id=secret`. |
| `pm_node` | The specific Proxmox node where the virtual machines will be provisioned. |

### Configuration Object (`k3s_config`)

The following properties can be set within the `k3s_config` object. Required fields are marked with **(*)**.

| Property | Default | Description |
| :--- | :--- | :--- |
| `base_vm_name` (*) | - | Prefix for the VM names (e.g., `k3s-0`, `k3s-1`). |
| `vms_amount` (*) | - | Number of virtual machines to provision for the cluster. |
| `disk_file_name` (*) | - | The name of the cloud-init disk image in Proxmox. |
| `tags` | `["terraform_created"]` | Set of tags to apply to the VMs. |
| `vm_id_start` | `300` | The starting VM ID in Proxmox. |
| `cpu_cores` | `2` | Number of CPU cores assigned to each VM. |
| `cpu_type` | `"x86-64-v2-AES"` | CPU model type. |
| `memory_dedicated` | `2048` | Dedicated RAM (in MB) for each node. |
| `disk_size` | `10` | Size of the root disk (in GB). |
| `datastore_id` | `"local-lvm"` | Proxmox storage ID for the VM disks. |
| `network_bridge` | `"vmbr0"` | The Proxmox network bridge for the VMs. |
| `ip_network_prefix`| `"192.168.1"` | The first three octets of the static IP subnet. |
| `ip_address_start` | `200` | The starting last octet for static IP assignment. |
| `ip_gateway` | `"192.168.1.1"` | The default gateway for the cluster network. |

### 3. Usage
Run the following commands from the project root:

```bash
# Initialize the project and modules
terraform init

# Review the execution plan
terraform plan

# Apply the changes
terraform apply
```

---

## Development & Best Practices
- **Scalability**: To add a new cluster type, define a new configuration object in the root `variables.tf` and add a corresponding module call in `main.tf`.
- **State Management**: It is recommended to use a remote backend (e.g., GitLab HTTP, S3, or PostgreSQL).
- **Security**: Never commit `.tfvars` files. Use the provided `terraform.tfvars.example` as a template.
- **Formatting**: Always run `terraform fmt -recursive` before submitting changes.
