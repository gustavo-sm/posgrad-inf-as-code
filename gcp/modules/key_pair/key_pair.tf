resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
  provisioner "local-exec" {
    command = <<EOT
        mkdir -p keys
        echo '${self.private_key_pem}' > ./keys/instance_key-${self.id}.pem
        chmod 400 ./keys/instance_key-${self.id}.pem
    EOT
  }
  provisioner "local-exec" {
    when = destroy
    command = "rm -f ./keys/instance_key-${self.id}.pem"
  }
}

output "private_key_name" {
    value = "instance_key-${tls_private_key.ssh_key.id}"
}

output "public_key"{
    value = tls_private_key.ssh_key.public_key_openssh
}

