################################################################################
# Network Module - Variables 
################################################################################

output "vpc_id" {
  value = module.networking.vpc_id
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.networking.private_subnet_ids
}

################################################################################
# Security Module - Variables 
################################################################################

output "public_security_group_id" {
  value = module.security.public_security_group_id
}

output "private_security_group_id" {
  value = module.security.private_security_group_id
}

output "database_security_group_id" {
  value = module.security.database_security_group_id
}

output "bastion_security_group_id" {
  value = module.security.bastion_security_group_id
}

################################################################################
# Bastion Module - Variables 
################################################################################

output "bastion_ip_public" {
  value = module.bastion.instance_ip_addr_public
}

output "bastion_ip_private" {
  value = module.bastion.instance_ip_addr_private
}

################################################################################
# DocumentDB Module - Variables 
################################################################################

output "document_db_endpoint" {
  value = module.database.mongodb_endpoint
}

output "mongodb_password_secret_arn" {
  value = module.database.mongodb_password_secret_arn
}

output "mongodb_connection_string_secret_arn" {
  value = module.database.mongodb_connection_string_secret_arn
}

################################################################################
# ALB Module - Variables 
################################################################################

output "alb_dns" {
  value = module.load_balance.alb_dns
}