module "vars" {
    source = "./modules/variables"
}
module "networking" {
    source = "./modules/networking"
}

resource "google_compute_instance" "rundeck-server" {
    name         = "rundeck-server"
    machine_type = "e2-small"


    boot_disk {
      initialize_params {
          image = module.vars.debian_image
      }
    }

    //access_config = {}

    network_interface {
        network = module.vars.network
        access_config {
            nat_ip = module.networking.rundeck-static-address
        }
    }
    
    metadata_startup_script = "echo hi > /test.txt"

}