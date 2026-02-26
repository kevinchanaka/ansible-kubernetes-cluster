.PHONY: node-setup cluster-create get-kubeconfig cluster-upgrade-plan cluster-upgrade cluster-update cluster-destroy

node-setup :
	ansible-playbook -i hosts.ini -u ubuntu playbooks/node-setup.yaml -e "reboot=${reboot}"

cluster-create :
	ansible-playbook -i hosts.ini -u ubuntu playbooks/cluster-create.yaml

get-kubeconfig :
	ansible-playbook -i hosts.ini -u ubuntu playbooks/get-kubeconfig.yaml

cluster-upgrade :
	ansible-playbook -i hosts.ini -u ubuntu playbooks/cluster-upgrade.yaml -e "input_version=${version} upgrade=${upgrade}"

cluster-update :
	ansible-playbook -i hosts.ini -u ubuntu playbooks/cluster-update.yaml

cluster-destroy :
	ansible-playbook -i hosts.ini -u ubuntu playbooks/cluster-destroy.yaml
