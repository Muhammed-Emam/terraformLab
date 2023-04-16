##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  region     = var.aws_region
}

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

}

# resource "aws_eip" "nat" {
#   vpc = true
# }

# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.pub-sub.id
# }


resource "aws_subnet" "pub-sub" {
  cidr_block              = var.vpc_subnets_cidr_blocks[0]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.available.names[0]

}

resource "aws_subnet" "private-sub" {
  cidr_block              = var.vpc_subnets_cidr_blocks[1]
  vpc_id                  = aws_vpc.vpc.id
  #map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.available.names[1]

}

# ROUTING #
resource "aws_route_table" "pub-rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    #nat_gateway_id = aws_nat_gateway.nat.id
    gateway_id = aws_internet_gateway.igw.id

  }

}

resource "aws_route_table_association" "rta-pub-sub" {
  subnet_id      = aws_subnet.pub-sub.id
  route_table_id = aws_route_table.pub-rtb.id
}

resource "aws_route_table_association" "rta-private-sub" {
  subnet_id      = aws_subnet.private-sub.id
  route_table_id = aws_route_table.private-rtb.id
}






# SECURITY GROUPS #

#ssh_from_anywhere
resource "aws_security_group" "ssh_from_anywhere" {
  name_prefix = "ssh_from_anywhere_"
  vpc_id = aws_vpc.vpc.id

  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

#ssh_and_port_3000
resource "aws_security_group" "ssh_and_port_3000" {
  name_prefix = "ssh_and_port_3000_"
  vpc_id = aws_vpc.vpc.id

  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }
  
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
}





  
# }
# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name   = "nginx_alb_sg"
  vpc_id = aws_vpc.vpc.id

  #Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "nginx_sg"
  vpc_id = aws_vpc.vpc.id

  # HTTP access from VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


