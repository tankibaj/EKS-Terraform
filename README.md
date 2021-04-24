# Provision an EKS Cluster using Terraform

The Amazon Elastic Kubernetes Service (EKS) is the AWS service for deploying, managing, and scaling containerized applications with Kubernetes.

Deploy an EKS cluster using Terraform and configure `kubectl` using Terraform output.




## Prerequisites

- [AWS account](https://portal.aws.amazon.com/billing/signup?nc2=h_ct&src=default&redirect_url=https%3A%2F%2Faws.amazon.com%2Fregistration-confirmation#/start) with the IAM permissions listed on the [EKS module documentation](https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/iam-permissions.md).

- [AWS CLI](https://aws.amazon.com/cli/)

  ```bash
  brew install awscli
  ```

- [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)

  ```bash
  brew install aws-iam-authenticator
  ```

- [Kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/)

  ```
  brew install kubernetes-cli
  ```

- [Terraform](https://www.terraform.io/downloads.html)

  ```bash
  brew install terraform
  ```

  



## Quick Start

#### Terraform

- Prepare your working directory for other commands

  ```bash
  terraform init
  ```

- Show changes required by the current configuration

  ```bash
  terraform plan
  ```

- Create infrastructure

  ```bash
  terraform apply
  ```

  


#### Configure kubectl

Now that you've provisioned your EKS cluster, you need to configure kubectl. Run the following command to retrieve the access credentials for your cluster and automatically configure kubectl.

```bash
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```



#### Test EKS cluster

```bash
kubectl get all
```



#### Clean up your workspace

```bash
terraform destroy
```

