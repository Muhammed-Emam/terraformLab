##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

data "local_file" "private_key" {
  filename = "/home/emam/.ssh/terraform"
}

resource "aws_key_pair" "key" {
  key_name   = "terraform_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDn0g85p0+D5gOq/XNPuyCAgxrz16yzp2/fxPrL8u7AT4GMAR77gKX6Cyzg6djYblmh79FcuJeDzS/JTLdEcLW0yTPLzhHi3e5NtSN5L68gNBLGuj6SE0BPJkOjSloX5samsqoCX/9DF275ZkXysnCWCCluoGcWH+fgYOi72qEDL8nm7bG9iLDrQgd7royaFPEx0k3RzflPbkzZfMKFbs2EaQap06bThS0EUqeemCVHBPz7QEF9YYikhcJAayAa290jvlTvjHoTnGgZ0A5PPPxgfeNj/Cb4avIZMW7/hjWC/hn9xB2BEKa515j4ybamEtRyzm9T3+XvPYi0I6GM3+G6XZ+l5SaKWDxNmeN0YWIuZW5+bV7ieuueNzGz4IFKEeTLVrhu2Q08YNGWKrPB/eR2C5Yj9IGlquXK4cjHi3CXlJ8x2CNd7+yxisdwKVG0MDmR75pOfRuhirnBUZa4/klC+kQ7rMgrJk6gIsMMffEuqh0HDMwR7dysLaIH058N/YU= root@iti"
}     

##################################################################################
# RESOURCES
##################################################################################

# INSTANCES #
resource "aws_instance" "bastion" {
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.pub-sub.id
  vpc_security_group_ids = [aws_security_group.ssh_from_anywhere.id]
  key_name               = aws_key_pair.key.key_name

  
  # provisioner "file" {
  #   source      = var.private_key_path
  #   destination = "/tmp/id_rsa"
  # }

  #tryyyyyyyyyyyyyyyyyyyyyyyyyyyy
  # provisioner "local-exec" {
  #   command = "ssh-keygen -t rsa -b 4096 -C 'bastion-key' -f '/home/emam/.ssh/bastion-key' -N ''"
  # }

  # # Copy bastion public key to application instance
  # provisioner "file" {
  #   source      = "/home/emam/.ssh/bastion-key.pub"
  #   destination = "/tmp/bastion-key.pub"
  # }

}
resource "aws_instance" "application" {
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private-sub.id
  vpc_security_group_ids = [aws_security_group.ssh_and_port_3000.id]

  # key_name               = aws_key_pair.key.key_name


  #tryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
  #tryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
  
  
  # provisioner "remote-exec" {
  #   inline = [
  #     "echo '${file("/tmp/bastion-key.pub")}' >> /home/ec2-user/.ssh/authorized_keys",
  #     "chmod 600 /home/ec2-user/.ssh/authorized_keys"
  #   ]

  #   connection {
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = file("/home/emam/.ssh/bastion-key")
  #     host        = aws_instance.bastion.private_ip
  #   }
  # }

}