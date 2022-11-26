variable "centos_image" {
    type = string
    default = "centos-cloud/centos-7"
}

output "centos_image" {
    value = var.centos_image
}