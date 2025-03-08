variable "region" {
  type = string
  default = "ap-southeast-1"
}

################################################################################
# Network Module - Variables 
################################################################################

variable "availability_zones" {
  type = list(string)
  nullable = false
}

variable "cidr_block" {
  type = string
  nullable = false
}

variable "public_subnet_ips" {
  type = list(string)
  nullable = false
  
}

variable "private_subnet_ips" {
  type = list(string)
  nullable = false
}

################################################################################
# Bastion Module - Variables 
################################################################################

variable "bastion_instance_type" {
  type        = string
  description = "Type of EC2 instance to launch. Example: t2.small"
  default = "t3.small"
}

################################################################################
# Database Module - Variables 
################################################################################

variable "db_username" {
  type = string
  description = "Admin Username for the database"
  nullable = false
  default = "admin"
}

################################################################################
# ECS Module - Variables 
################################################################################

variable "frontend_ecr_repo_url" {
  type = string
  description = "The URI of the ECR repository for the Frontend application"
  nullable = false
}

variable "backend_ecr_repo_url" {
  type = string
  description = "The URI of the ECR repository for the Backend application"
  nullable = false
}