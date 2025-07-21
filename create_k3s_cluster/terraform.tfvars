base_vm_name = "k3s"
vms_amount = 2
user_data_file_name="user-data.yaml"
template_name = "k3s-node-template"
tags = ["terraform_created"]

# Cloud image section
ubuntu_cloud_image_url="https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"
ubuntu_cloud_image="ubuntu-24.04-server-cloudimg-amd64.qcow2"

# Cloud init section