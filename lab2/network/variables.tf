variable vpc_cidr_block {
    type = string
}


variable company-name {
    type = string

}

variable vpc_subnets_cidr_blocks {
    type = list(string)

}


variable map_public_ip_on_launch {
    type = bool
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  }
