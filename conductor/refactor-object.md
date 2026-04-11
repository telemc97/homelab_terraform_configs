# Implementation Plan: Refactor to Configuration Object

## Objective
Reduce architectural redundancy and improve scalability by consolidating individual VM, hardware, and networking variables into a single, structured `cluster_config` object variable. This change allows adding new clusters in the future with a single structured block rather than repeating 15+ individual variables.

## Key Files & Context
- **Root `variables.tf`**: Consolidate individual cluster variables into a single `cluster_config` object.
- **Root `main.tf`**: Update the `module "k3s_cluster"` call to pass the `cluster_config` object.
- **Module `create_k3s_cluster/variables.tf`**: Replace individual variables with the `config` object variable.
- **Module `create_k3s_cluster/main.tf`**: Update resource definitions to reference values via `var.config.<property>`.
- **`terraform.tfvars` & `terraform.tfvars.example`**: Restructure values to fit the new object format.

## Implementation Steps

1.  **Define Configuration Object in Root:**
    -   In `variables.tf`, remove individual VM/networking variables (`vms_amount`, `cpu_cores`, `memory_dedicated`, `ip_address_start`, etc.).
    -   Define a new variable `k3s_config` of type `object(...)` containing all these properties with their types and descriptions.

2.  **Update the Module Variables:**
    -   In `create_k3s_cluster/variables.tf`, similarly replace the individual variables with a `config` variable of the same object type.
    -   *Note*: Global credentials like `pm_node`, `ci_username`, `ci_password`, and `ssh_ansible_public_key` can remain separate if they apply to the whole Proxmox environment, or they can be moved inside the object if they are cluster-specific. We will keep credentials separate for security and make the object strictly about cluster sizing/networking.

3.  **Refactor Module Main.tf:**
    -   In `create_k3s_cluster/main.tf`, replace `var.cpu_cores` with `var.config.cpu_cores`, `var.vms_amount` with `var.config.vms_amount`, etc.

4.  **Update Root Orchestrator:**
    -   In `main.tf`, update the module block to simply pass:
        ```hcl
        config = var.k3s_config
        ```
    -   Continue passing the global credentials separately.

5.  **Restructure tfvars:**
    -   Update `terraform.tfvars` and `terraform.tfvars.example` to use the new object structure:
        ```hcl
        k3s_config = {
          vms_amount       = 2
          base_vm_name     = "k3s"
          disk_file_name   = "ubuntu-24.04-server-cloudimg-amd64.qcow2"
          # ... hardware and networking settings
        }
        ```

6.  **Verification & Testing:**
    -   Run `terraform fmt -recursive` to ensure proper formatting.
    -   Run `terraform validate` to confirm the syntax and variable types are correct.

## Pros & Cons
- **Pros**: Drastically reduces boilerplate code when instantiating new modules. Makes `terraform.tfvars` cleaner through grouping.
- **Cons**: Requires rewriting the current variables, which adds a layer of abstraction (using `var.config.x` instead of `var.x`).
