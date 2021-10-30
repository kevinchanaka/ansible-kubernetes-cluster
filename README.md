# ansible-kubernetes-cluster

Ansible playbook to provision a kubernetes cluster via kubeadm

This playbook is only supported for Ubuntu 20 LTS instances but should also work for Ubuntu 18 LTS

## Preparation

Run the following commands to prepare Python virtual environment for Ansible

```
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Usage

Populate the `group_vars/all.yml` and `hosts.yml` with appropriate configuration

Run the following command to install packages and kubernetes components required for cluster creation. This will also reboot the targeted nodes if required

`ansible-playbook -i hosts.yml prerequisites.yml`

Next, run the following command to provision the cluster

`ansible-playbook -i hosts.yml cluster-create.yml`

If errors are encountered during provisioning, or if you would like to clean-up the cluster, run the following command

`ansible-playbook -i hosts.yml cluster-destroy.yml`

To update cluster configuration (e.g. updating static manifests) without updating kubernetes version, run the following

`ansible-playbook -i hosts.yml cluster-update.yml`

Finally, to update the kubernetes version of the cluster, run the following

`ansible-playbook -i hosts.yml cluster-upgrade.yml`

## Configuration

### Variables

Variables are configured in the `group_vars/all.yml` file. Please refer to the comments within this file for supported options.

### Hosts

The `hosts.yml` file is structed as follows. Note that the IP address specified in `master` is the node where the `kubeadm init` command is run. The additional node IP addresses in `extra_masters` specify additional control plane nodes where the `kubeadm join` command is used. The node IPs specified in `workers` join the cluster with `kubeadm join` as worker nodes. 

```
all:
  children:
    master:
      hosts:
        <IP_OF_CONTROL_PLANE_NODE_1>:
    extra_masters:
      hosts:
        <IP_OF_CONTROL_PLANE_NODE_2>:
        <IP_OF_CONTROL_PLANE_NODE_3>:
    workers:
      hosts:
        <IP_OF_WORKER_NODE_1>:
        <IP_OF_WORKER_NODE_2>:
        <IP_OF_WORKER_NODE_3>:
```
