# Kubernetes DEMO

## Boot up an EKS Cluster on AWS with CloudFormation + Ansible

To boot up an EKS Cluster on AWS we can use the `eks_cluster_up` task.

```bash
make eks_cluster_up
```

The following variables are editable at the `./ansible/hosts.yml` file:

- **EKS Cluster Vars**
  - `eks_cluster_name`: 
    - Default value: `kubernetes-demo`
    - Description: EKS Cluster name
  - `eks_cluster_version`: 
    - Default value: `'1.11'`
    - Description: EKS Kubernetes Cluster
  - `eks_cluster_state`: 
    - Default value: `present`
    - Description:  EKS Kubernetes Cluster state
    - Valid values:
      - `present`
      - `absent`
- **EKS Cluster Auto Scaling Vars**
  - `eks_cluster_auto_scaling_group_size`: 
    - Default value: `1`
    - Description: Size of the auto scaling group.
  - `eks_cluster_auto_scaling_group_max_size`: 
    - Default value: `4`
    - Description: Maximum value of the auto scaling group.
  - `eks_cluster_auto_scaling_group_desired_capacity`: 
    - Default value: `1`
    - Description: Desired value of the auto scaling group.
- **EKS Cluster Node Vars**
  - `eks_cluster_node_volume_size`: 
    - Default value: `20`
    - Description: Size of the volumes on the auto scaling group nodes.
  - `eks_cluster_node_group_name`: 
    - Default value: `'{{ eks_cluster_name }}-node-group-name'`
    - Description: Name of the auto scaling group
  - `eks_cluster_node_image_id`: 
    - Default value: `ami-053e2ac42d872cc20`
    - Description: EKS Optimized image. Default value is for `us-east-1` region.
  - `eks_cluster_node_instance_type`: 
    - Default value: `m5.large`
    - Description: EC2 instance size for auto scaling nodes.
  - `eks_cluster_node_key_name`: 
    - Default value: `kubernetes`
    - Description: Name of the Key Pair to access the EC2 nodes

There are also some secret vars that must be configured on a file called `secret.yml` stored on the `ansible` directory. Its password should be stored on a `password` file, also on the `ansible` directory. The `secret.yml` file should be encrypted with `ansible-vault`.

- **AWS Secret vars**
  - `aws_access_key`: AWS Access Key
  - `aws_secret_key`: AWS Secret Key
  - `region`: AWS Region
  - `aws_profile`: AWS Profile 
    

_OBS: The EKS cluster can be terminated by using the `make eks_cluster_down` task._

To login to the cluster for the first time we need to use [`aws-iam-authenticator`](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) package, and the `awscli`.

```bash
aws-iam-authenticator token -i {{ eks_cluster_name }}
# An authentication token should be found on the response
aws eks update-kubeconfig --name {{ eks_cluster_name }} --profile {{ aws_profile }}
```

If everything went well, we'll be able to reach the EKS cluster.

```bash
kubectl cluster-info
```

Or just run the `make eks_cluster_set_up` task.

At the moment, we don't have any pods on the cluster, even though the nodes are up and running, we need to add them. The `make eks_cluster_add_nodes` task also takes care of this. We basically need to create a new `ConfigMap` and add it to the cluster.

Now, we should be able to see the nodes connected to the cluster

```bash
kubectl get nodes
```

### Install the Kubernetes Dashboard

To install the Kubernetes Dashboard run the `make eks_cluster_kubernetes_dashboard` task. On the last task you'll see the value for the `eks_admin_token` variable. Use that value to authenticate to the dashboard. After running the task, you can access the Kubernetes Cluster by running the following command:

```bash
kubectl proxy
```