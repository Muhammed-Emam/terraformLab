provider "aws" {
  region     = var.aws_region
}


module "my-network" {
  source= "./network"

  vpc_cidr_block = var.vpc_cidr_block
  company-name = var.company-name
  vpc_subnets_cidr_blocks = var.vpc_subnets_cidr_blocks
  map_public_ip_on_launch = var.map_public_ip_on_launch
  enable_dns_hostnames = var.enable_dns_hostnames

}




