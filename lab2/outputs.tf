# output "private_ip_address_application" {
#   value = aws_instance.application.private_ip
# }


output "public_ip_address_bastion" {
  value = aws_instance.bastion.public_ip
}



# output "elasticache_endpoint" {
#   value = aws_elasticache_cluster.cache.configuration_endpoint
# }



# output "rds_endpoint" {
#   value = aws_db_instance.rds.endpoint
# }

