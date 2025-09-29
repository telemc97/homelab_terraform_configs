base_vm_name = "k3s"
template_name = "k3s-node-template"
tags = ["terraform_created"]
vms_amount = 2
disk_file_name = "ubuntu-24.04-server-cloudimg-amd64.qcow2"

# Cloud init section
ci_username = "telemc"
ci_password = "$6$rounds=4096$6cUScglJTTDSZc8I$eSfyBuLMEC9OGwG7n7/dURgKZE4XDBlAgw/xiEKqZKY/5MvtTPDmP6W.v.pl1QY.1RxCIWtMyoL0zcw4ezWKq."
ssh_ansible_public_key = ""
ssh_auxilery_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKYYwDDO5yADbMk8v9Zo/Hi+t8Rkd8RI5ARcARlwFjxQ tilemahosmitroudas@Tilemahoss-MacBook-Pro.local"