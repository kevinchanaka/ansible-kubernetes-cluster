# ansible-kubernetes-cluster

Ansible playbook to provision a kubernetes cluster via kubeadm

## Preparation

Run the following commands to prepare Python virtual environment for Ansible

```
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Usage

Populate the `group_vars/all.yml` and `hosts.yml` with appropriate configuration and run the following command to provision the cluster

`ansible-playbook -i hosts.yml cluster-create.yml`

If errors are encountered during provisioning, or if you would like to clean-up the cluster, run the following command

`ansible-playbook -i hosts.yml cluster-destroy.yml`

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
