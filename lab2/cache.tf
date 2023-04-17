# resource "aws_elasticache_subnet_group" "private_subnets" {
#   name        = "my-elasticache-subnet-group"
#   description = "Subnet group for Elasticache cluster"
#   subnet_ids  = [module.my-network.private-sub1-id, module.my-network.private-sub2-id]
# }

# resource "aws_elasticache_cluster" "cache" {
#   cluster_id           = "my-cache-cluster"
#   engine               = "memcached"
#   node_type            = "cache.t2.micro"
#   num_cache_nodes      = 1
#   #parameter_group_name = aws_elasticache_parameter_group.cache.name
#   port                 = 11211
#   #force_destroy = true

#   subnet_group_name    = aws_elasticache_subnet_group.private_subnets.name
#   security_group_ids   = [aws_security_group.cache-sg.id]
# }

# # resource "aws_elasticache_parameter_group" "cache" {
# #   name   = "my-elasticache-param-group"
# #   family = "memcached1.6"

# #   parameter {
# #     name  = "max_item_size"
# #     value = "20480"
# #   }
# # }

# resource "aws_security_group" "cache-sg" {
#   name        = "elasticache-security-group"
#   description = "Security group for Elasticache"
#   vpc_id      = module.my-network.vpc_id
  
#   ingress {
#     from_port   = 11211
#     to_port     = 11211
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }






















# # resource "aws_elasticache_subnet_group" "private_subnets" {
# #   name        = "my-elasticache-subnet-group"
# #   description = "subnet group for Elasticache cluster"
# #   subnet_ids  = [module.my-network.private-sub1-id, module.my-network.private-sub2-id]
# # }


# # resource "aws_elasticache_cluster" "cache" {
# #   cluster_id   = "my-cache-cluster"
# #   engine               = "memcached"
# #   node_type            = "cache.t2.micro"
# #   num_cache_nodes      = 1
# #   parameter_group_name = aws_elasticache_parameter_group.cache.name
# #   port                 = 11211
  
# #   subnet_group_name = aws_elasticache_subnet_group.private_subnets.name
# #   security_group_ids = [aws_security_group.cashe-sg.id]
# # }

# # resource "aws_elasticache_parameter_group" "cache" {
  
# #   name        = "my-elasticache-param-group"
# #   family      = "memcached1.6"

# #   parameter {
# #     name  = "max_item_size"
# #     value = "20480"
# #   }
# # }

# # # Elastic_Cache security group 

# # resource "aws_security_group" "cashe-sg" {
# #   name        = "elasticache-security-group"
# #   description = "security group for Elasticache"
# #   vpc_id      = module.my-network.vpc_id
  
# #   ingress {
# #     from_port   = 11211
# #     to_port     = 11211
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }
# # }