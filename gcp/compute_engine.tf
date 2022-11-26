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
          image = module.vars.centos_image
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

      provisioner "file" {
        source      = "./provisioning_scripts/rundeck.sh"
        destination = "/tmp/rundeck.sh"
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
        "sudo chmod +x /tmp/rundeck.sh",
        "sudo sh /tmp/rundeck.sh"
      ]
    }

    service_account {
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      email  = "tf-iac@prj-iac-369104.iam.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }

}