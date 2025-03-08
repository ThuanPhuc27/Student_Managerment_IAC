variable "region" {
  type = string
  default = "ap-northeast-2"
}

variable "vpc_id" {
  type = string
  description = "The VPC ID"
  nullable = false
  
}