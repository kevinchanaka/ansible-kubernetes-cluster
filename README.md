# ansible-kubernetes-cluster

Ansible playbook to provision a kubernetes cluster via kubeadm

This playbook has only been tested for Ubuntu 22.04 LTS (jammy) nodes

## Quickstart

1. Install `ansible` tool by referring to documentation [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible)

2. Populate the `group_vars/all.yaml` with relevant configuration. This file contains configuration such as what version of Kubernetes and containerd to install

3. Populate the `kubeadm-config.yaml` file with relevant configuration for your cluster. Please refer to the comments within this file and [kubeadm reference](https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta3/) for more information

4. Add IP addresses of machines to `hosts.ini` file. Note that the first master node specified is the node where `kubeadm init` is run. For additional master nodes as well as worker nodes, `kubeadm join` is used

```
[masters]
<IP_OF_CONTROL_PLANE_NODE_1>
<IP_OF_CONTROL_PLANE_NODE_2>
<IP_OF_CONTROL_PLANE_NODE_3>

[workers]
<IP_OF_WORKER_NODE_1>
<IP_OF_WORKER_NODE_2>
<IP_OF_WORKER_NODE_3>
```

4. Run the `make node-setup` command to install pre-requisite software on nodes (e.g. containerd) and `make cluster-create` to provision Kubernetes cluster

## Reference

| Command | Description |
| --- | --- |
| `make node-setup` | Performs pre-requisite steps and installs required software on nodes such as containerd |
| `make cluster-create` | Provisions Kubernetes cluster based on `kubeadm-config.yaml` settings |
| `make get-kubeconfig` | Generates an admin kubeconfig for the cluster, which is written to a folder within the `playbooks` directory |
| `make cluster-update` | Updates cluster config based on adjustments to `kubeadm-config.yaml` file. Changing static manifests is the only supported operation by this playbook, refer [here](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-reconfigure/#reconfiguring-the-cluster) for more information |
| `make cluster-upgrade-plan` | Plans cluster upgrade and prints ouptut for further review, recommended to run this before upgrading cluster |
| `make cluster-upgrade` | Upgrades Kubernetes to the version specified in `group_vars/all.yaml` file |
| `make cluster-destroy` | Deletes Kubernetes cluster |
