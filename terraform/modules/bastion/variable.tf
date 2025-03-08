variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to launch. Example: t2.small"
  default = "t3.small"
}

variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable security_groups {
  type = list(string)
  default = ["default"]
}

variable "subnet_id" {
  type = string
}

variable "amis" {
  type = map(any)
  default = {
    "ap-northeast-2" : "ami-0077297a838d6761d" #Ubuntu 22.04 Jammy
  }
}