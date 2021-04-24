variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "AWS region"
}

variable "cluster_version" {
  type        = string
  default     = "1.19"
  description = "Kubernetes version"
}

locals {
  cluster_name = "hello-eks-${random_string.suffix.result}"
}

variable "env_tag" {
  type        = string
  default     = "Managed by terraform"
  description = "Environment tag"
}
