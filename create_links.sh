#!/bin/bash

# create_cluster symbolic links
ln -s ../common/providers.tf create_k3s_cluster/providers.tf
ln -s ../common/secrets.tf create_k3s_cluster/secrets.tf
ln -s ../common/global_variables.tf create_k3s_cluster/global_variables.tf
