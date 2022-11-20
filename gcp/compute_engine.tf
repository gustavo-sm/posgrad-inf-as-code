module "vars" {
    source = "./modules/variables"
}
module "networking" {
    source = "./modules/networking"
}

module "ssh_key" {
    source = "./modules/key_pair"
}


resource "google_compute_instance" "rundeck-server" {
    name         = "rundeck-server"
    machine_type = "e2-small"


    boot_disk {
      initialize_params {
          image = module.vars.debian_image
      }
    }

    network_interface {
        network = module.vars.network
        access_config {
            nat_ip = module.networking.rundeck-static-address
        }
    }
    metadata = {
        ssh-keys = "${module.vars.vm-user}:${module.ssh_key.public_key}"
    }
    
    provisioner "remote-exec" {
      connection {
        host        = module.networking.rundeck-static-address
        type        = "ssh"
        user        = module.vars.vm-user
        timeout     = "500s"
        private_key = file("./keys/${module.ssh_key.private_key_name}.pem")
      }
      inline = [    
        "sudo sh ./provisioning_scripts/rundeck.sh"
      ]
    }

}