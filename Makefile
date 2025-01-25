.PHONY: node-setup cluster-create get-kubeconfig cluster-upgrade-plan cluster-upgrade cluster-update cluster-destroy

node-setup :
	ansible-playbook -i hosts.ini playbooks/node-setup.yaml -e "reboot=${reboot}"

cluster-create :
	ansible-playbook -i hosts.ini playbooks/cluster-create.yaml

get-kubeconfig :
	ansible-playbook -i hosts.ini playbooks/get-kubeconfig.yaml

cluster-upgrade :
	ansible-playbook -i hosts.ini playbooks/cluster-upgrade.yaml -e "input_version=${version} upgrade=${upgrade}"

cluster-update :
	ansible-playbook -i hosts.ini playbooks/cluster-update.yaml

cluster-destroy :
	ansible-playbook -i hosts.ini playbooks/cluster-destroy.yaml
