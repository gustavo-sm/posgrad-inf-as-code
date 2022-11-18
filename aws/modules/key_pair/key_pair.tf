resource "tls_private_key" "gen_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "instance_key"
  public_key = tls_private_key.gen_key.public_key_openssh
}

output "key_pair_name" {
    value = aws_key_pair.generated_key.key_name
}