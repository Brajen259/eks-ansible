.PHONY: eks_cluster_up eks_cluster_down templates

eks_cluster_up: ANSIBLE_CONFIG=./ansible.cfg
eks_cluster_up: 
	ansible-playbook eks_cluster.yml --extra-vars "eks_cluster_state=present"

eks_cluster_down: ANSIBLE_CONFIG=./ansible.cfg
eks_cluster_down: 
	ansible-playbook eks_cluster.yml --extra-vars "eks_cluster_state=absent" --tags "cloudformation"

eks_cluster_add_nodes: ANSIBLE_CONFIG=./ansible.cfg
eks_cluster_add_nodes:
	ansible-playbook eks_cluster_add_nodes.yml -v

eks_cluster_set_up: ANSIBLE_CONFIG=./ansible.cfg
eks_cluster_set_up:
	ansible-playbook eks_cluster_set_up.yml -v

eks_cluster_kubernetes_dashboard: ANSIBLE_CONFIG=./ansible.cfg
eks_cluster_kubernetes_dashboard:
	ansible-playbook eks_cluster_kubernetes_dashboard.yml -v

eks_cluster_ecsdemo: ANSIBLE_CONFIG=./ansible.cfg
eks_cluster_ecsdemo:
	ansible-playbook eks_cluster_ecsdemo.yml -v