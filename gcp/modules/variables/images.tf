variable "debian_image" {
    type = string
    default = "debian-cloud/debian-11"
}

output "debian_image" {
    value = var.debian_image
}