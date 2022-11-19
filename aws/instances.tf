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

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install apache2 mysql-server php libapache2-mod-php php-mysql -y",
      "exit"
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
  ami           = module.ami.ubuntu_ami_id
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

  provisioner "remote-exec" {
    inline = [
      "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt update -y",
      "sudo apt install jenkins",
      "sudo systemctl start jenkins",
      "exit"
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("./keys/${self.key_name}.pem")
  }
}