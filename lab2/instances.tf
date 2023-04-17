##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}


resource "tls_private_key" "key" {
    algorithm = "RSA"
    rsa_bits = 4096
}


resource "local_file" "prv_key_local_file" {
  content = tls_private_key.key.private_key_pem
  filename= "/home/emam/.ssh/terraform"
}


locals {
  private_key_content = file("/home/emam/.ssh/terraform")
  depends_on          = [local_file.prv_key_local_file]
}

resource "aws_key_pair" "public_key" {
  key_name  = "pub-key1"  //should be variable as if we run it in diffrent worksapace won't allow duplicate naming
  public_key = tls_private_key.key.public_key_openssh
}


data "template_file" "user_data" {
  template = <<-EOT
    #!/bin/bash

    #this line is not working for some reason !!!!!!!!!!!!!!
    sudo echo "${local.private_key_content}" > /home/ec2-user/private_key.pem

    sudo chmod 400 /home/ec2-user/private_key.pem

    # Add the private key to the SSH agent
    eval $(ssh-agent -s)
    ssh-add /home/ec2-user/private_key.pem
  EOT
}

     

##################################################################################
# RESOURCES
##################################################################################

# INSTANCES #
resource "aws_instance" "bastion" {
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.instance_type
  subnet_id              = module.my-network.pub-sub1-id
  vpc_security_group_ids = [aws_security_group.ssh_from_anywhere.id]
  key_name               = aws_key_pair.public_key.key_name
  user_data     = data.template_file.user_data.rendered



  provisioner "local-exec" {
    command = "echo Bastion public IP: ${self.public_ip} >> bastion.txt"
  }


}




# resource "aws_instance" "application" {
#   ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
#   instance_type          = var.instance_type
#   subnet_id              = module.my-network.private-sub1-id
#   vpc_security_group_ids = [aws_security_group.ssh_and_port_3000.id]
#   key_name               = aws_key_pair.public_key.key_name
# }



