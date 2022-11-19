variable "vm-user" {
    type = string
    default = "" #colocar nome de usuario do gcp aqui
}

output "vm-user" {
    value = var.vm-user
}