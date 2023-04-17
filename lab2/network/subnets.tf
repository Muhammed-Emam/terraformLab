data "aws_availability_zones" "available" {}

resource "aws_subnet" "pub-sub1" {
  cidr_block              = var.vpc_subnets_cidr_blocks[0]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.available.names[0]

}


resource "aws_subnet" "private-sub1" {
  cidr_block              = var.vpc_subnets_cidr_blocks[1]
  vpc_id                  = aws_vpc.vpc.id
  #map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.available.names[0]

}

resource "aws_subnet" "pub-sub2" {
  cidr_block              = var.vpc_subnets_cidr_blocks[2]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.available.names[1]

}



resource "aws_subnet" "private-sub2" {
  cidr_block              = var.vpc_subnets_cidr_blocks[3]
  vpc_id                  = aws_vpc.vpc.id
  #map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.available.names[1]

}