# Learn Terraform - Provision an EKS Cluster

## This Repository is a property of EtechDevops Master class. Follow it carefully to provision your new eks cluster

# Terraform and AWS EKS Tutorial

This tutorial will guide you through deploying AWS EKS clusters using Terraform. The assumption is that you have a basic understanding of Terraform and HCP Terraform workflows. If you're unfamiliar with either, consider completing the following tutorials first:

- [Get Started with Terraform](https://learn.hashicorp.com/collections/terraform/getting-started)

## Prerequisites

Before you start, make sure you have the following:

- **Terraform v1.3+** installed locally.  
  You can install it from the [Terraform download page](https://www.terraform.io/downloads).

- **AWS account**.  
  If you don’t already have one, create an account at [AWS](https://aws.amazon.com/).

- **AWS CLI v2.7.0+ or v1.24.0+** installed and configured.  
  [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) if necessary, and run `aws configure` to set up access.

- **AWS IAM Authenticator** installed.  
  Follow the instructions [here](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html) for installation.

- **kubectl v1.24.0+** installed.  
  [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) if needed.

## Next Steps

After ensuring that you meet the prerequisites, proceed with setting up the necessary Terraform configurations and deploying the EKS cluster as outlined in the tutorial. For detailed Terraform configurations, you can refer to the respective `.tf` files in this project.

## Final steps

Create a '~/.kube/config' on your local machine
```
 $ sudo mkdir ~/.kube && touch ~/.kube/config
 $ sudo chown -R $USER ~/.kube/config
```
## Add your cluster context to your ~/.kube/config file using this:

```
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
kubectl cluster-info
kubectl get nodes
```


