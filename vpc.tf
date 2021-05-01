variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets"
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24",
    "10.0.8.0/24",
    "10.0.9.0/24",
    "10.0.10.0/24",
    "10.0.11.0/24",
    "10.0.12.0/24",
    "10.0.13.0/24",
    "10.0.14.0/24",
    "10.0.15.0/24",
    "10.0.16.0/24"
  ]
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets"
  type        = list(string)
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24",
    "10.0.105.0/24",
    "10.0.106.0/24",
    "10.0.107.0/24",
    "10.0.108.0/24",
    "10.0.109.0/24",
    "10.0.110.0/24",
    "10.0.111.0/24",
    "10.0.112.0/24",
    "10.0.113.0/24",
    "10.0.114.0/24",
    "10.0.115.0/24",
    "10.0.116.0/24"
  ]
}

variable "database_subnets_cidr_blocks" {
  description = "Available cidr blocks for database subnets"
  type        = list(string)
  default = [
    "10.0.201.0/24",
    "10.0.202.0/24",
    "10.0.203.0/24",
    "10.0.204.0/24",
    "10.0.205.0/24",
    "10.0.206.0/24",
    "10.0.207.0/24",
    "10.0.208.0/24",
    "10.0.209.0/24",
    "10.0.210.0/24",
    "10.0.211.0/24",
    "10.0.212.0/24",
    "10.0.213.0/24",
    "10.0.214.0/24",
    "10.0.215.0/24",
    "10.0.216.0/24"
  ]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name = "vpc-${local.cluster_name}"
  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  public_subnets  = slice(var.public_subnet_cidr_blocks, 0, 3)
  private_subnets = slice(var.private_subnet_cidr_blocks, 0, 3)
  # database_subnets = slice(var.database_subnets_cidr_blocks, 0, 3)

  enable_nat_gateway = true # If false.. Private subnet will have not intenet access.
  single_nat_gateway = true # If true... One shared NAT gateway will be created for multiple AZ. (if NAT AZ goes down, private subnet in other AZs will lose Internet Access)
  # one_nat_gateway_per_az = true     # If true... For each AZ a NAT Gateway will be created. (NAT Gateway High Availability)

  enable_vpn_gateway = false

  # DNS hostname resolution set.
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
