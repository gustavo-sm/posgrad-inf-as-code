data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ami" "amazon_linux_ami" {
  most_recent = true

  filter {
   name   = "owner-alias"
   values = ["amazon"]
  }
  
  
  filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
  }
}

output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu_ami.id
}

output "amazon_linux_ami_id" {
  value = data.aws_ami.amazon_linux_ami.id
}