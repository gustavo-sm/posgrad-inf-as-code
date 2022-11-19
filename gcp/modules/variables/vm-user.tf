variable "vm-user" {
    type = string
    default = "gustavo1sad"
}

output "vm-user" {
    value = var.vm-user
}