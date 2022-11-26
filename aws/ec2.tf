module "ami" {
  source = "./modules/ami"
}

module "security_group" {
  source = "./modules/security_group"
}

module "key_pair" {
  source = "./modules/key_pair"
}

resource "aws_instance" "LAMP_server" {
  ami           = module.ami.ubuntu_ami_id
  instance_type = "t2.micro"
  key_name = module.key_pair.key_pair_name
  security_groups = [module.security_group.sg_name_webserver]
  associate_public_ip_address = true

  tags = {
    Name = "LAMP_server"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm -f ./keys/${self.key_name}.pem"
  }

  provisioner "file" {
    source      = "./provisioning_scripts/LAMP.sh"
    destination = "/tmp/LAMP.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/LAMP.sh",
      "sudo sh /tmp/LAMP.sh"
    ]

  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("./keys/${self.key_name}.pem")
  }

}

resource "aws_instance" "Jenkins_server" {
  ami           = module.ami.amazon_linux_ami_id
  instance_type = "t2.micro"
  key_name = module.key_pair.key_pair_name
  security_groups = [module.security_group.sg_name_jenkinsserver]
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins_server"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm -f ./keys/${self.key_name}.pem"
  }

  provisioner "file" {
    source      = "./provisioning_scripts/jenkins.sh"
    destination = "/tmp/jenkins.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/jenkins.sh",
      "sudo sh /tmp/jenkins.sh"
    ]
  }


  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("./keys/${self.key_name}.pem")
  }
}