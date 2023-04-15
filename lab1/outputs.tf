output "private_ip_address_application" {
  value = aws_instance.application.private_ip
}


output "public_ip_address_bastion" {
  value = aws_instance.bastion.public_ip
}