module "vars" {
    source = "../variables"
}

resource "google_compute_firewall" "rundeck-firewall" {
  name    = "rundeck-firewall"
  network = module.vars.network
  allow {
    protocol = "tcp"
    ports    = ["22", "4440", "4443", "80"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "rundeck-static-address" {
  name = "rundeck-static-address"
  depends_on = [ google_compute_firewall.rundeck-firewall ]
}

output "rundeck-static-address" {
  value = google_compute_address.rundeck-static-address.address
}