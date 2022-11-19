resource "tls_private_key" "gen_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "instance_key" {
  key_name   = "instance_key_${timestamp()}"
  public_key = tls_private_key.gen_key.public_key_openssh

  provisioner "local-exec" {
      command =  <<EOT
                  mkdir -p keys
                  echo '${tls_private_key.gen_key.private_key_pem}' > ./keys/${self.key_name}.pem
                  chmod 400 ./keys/${self.key_name}.pem
                 EOT
  }

}

output "key_pair_name" {
    value = aws_key_pair.instance_key.key_name
}