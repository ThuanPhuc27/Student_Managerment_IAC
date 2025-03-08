region = "ap-northeast-2"

################################################################################
# Network Module - Variables 
################################################################################

availability_zones = [ "ap-northeast-2a", "ap-northeast-2b" ]

cidr_block = "10.0.0.0/16"

public_subnet_ips = [ "10.0.1.0/24", "10.0.2.0/24" ]

private_subnet_ips = [ "10.0.10.0/24", "10.0.20.0/24" ]

################################################################################
# Bastion Module - Variables 
################################################################################

bastion_instance_type = "t3.small"

################################################################################
# Database Module - Variables 
################################################################################ 

db_username="dbadmin"

################################################################################
# ECS Module - Variables 
################################################################################

frontend_ecr_repo_url = "160885258086.dkr.ecr.ap-northeast-2.amazonaws.com/student_management_fe"

backend_ecr_repo_url = "160885258086.dkr.ecr.ap-northeast-2.amazonaws.com/student_management_be"