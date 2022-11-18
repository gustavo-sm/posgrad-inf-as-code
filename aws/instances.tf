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
  ami           = module.ami.ami_id
  instance_type = "t2.micro"
  key_name = module.key_pair.key_pair_name
  security_groups = [module.security_group.security_group_name]
  associate_public_ip_address = true
  tags = {
    Name = "LAMP"
  }
}