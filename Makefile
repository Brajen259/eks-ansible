.PHONY: templates eks_cluster_ecsdemo eks_cluster_up eks_cluster_down eks_cluster_add_nodes eks_cluster_set_up eks_cluster_kubernetes_dashboard

templates:
	cd ansible && make templates && cd ..

eks_cluster_up:
	cd ansible && make eks_cluster_up && cd ..

eks_cluster_down:
	cd ansible && make eks_cluster_down && cd ..

eks_cluster_add_nodes:
	cd ansible && make eks_cluster_add_nodes && cd ..

eks_cluster_set_up:
	cd ansible && make eks_cluster_set_up && cd ..

eks_cluster_kubernetes_dashboard:
	cd ansible && make eks_cluster_kubernetes_dashboard && cd ..

eks_cluster_ecsdemo:
	cd ansible && make eks_cluster_ecsdemo && cd ..