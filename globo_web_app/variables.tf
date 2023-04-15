variable "aws_access_key" {
    type = string
    description = "Access key ID"
    sensitive = true
}

variable "aws_secret_key" {
  type = string
  description = "Sectret Key"
  sensitive = true
}

variable "aws_region" {
  type = string
  description = "aws region"
  default = "us-east-1"
}

variable "enable_dns_hostnames" {
  type = bool
  description = "Enabling instance hostname within the vpc"
  default = true
}

variable "vpc_cidr_block" {
    type = string
    description = "VPC cidr_block"
    default = "10.0.0.0/16"
}

variable "vpc_subnets_cidr_block" {
  type = list(string)
  description = "cidr block range for vpc 1"
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "map_public_ip_on_launch" {
    type= bool
    description = "allow subnet to give instances public up address"
    default = true
}

variable "instance_type" {
    type = string
    description = "tyoe of the ec2 instances"
    default = "t2.micro"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "Globomantics"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
}

variable "billing_code" {
  type        = string
  description = "Billing code for resource tagging"
}