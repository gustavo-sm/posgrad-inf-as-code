variable "region_central" {
    type = string
    default = "us-central1"
}

variable "zone_centralb" {
    type = string
    default = "us-central1-b"
}


output "region_central" {
    value = var.region_central
}

output "zone_centralb" {
    value = var.zone_centralb
}