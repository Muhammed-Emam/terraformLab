# resource "aws_db_subnet_group" "rds_subnet_group" {
#   name       = "rds-subnet-group"
#   subnet_ids  = [module.my-network.private-sub1-id, module.my-network.private-sub2-id]
  
# }


# resource "aws_db_instance" "rds" {
#   allocated_storage    = 20
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t2.micro"
#   db_name                 = "myrds"
#   username             = "admin"
#   password             = "password"
#   #data_source username password
#   skip_final_snapshot    = true

  
#   vpc_security_group_ids = [aws_security_group.mysql-sg.id]
#   db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.name
#   }


# resource "aws_security_group" "mysql-sg" {
    
#     vpc_id      = module.my-network.vpc_id

#   ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

