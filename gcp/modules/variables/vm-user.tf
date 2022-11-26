variable "vm-user" {
    type = string
    default = "vm-user" #colocar nome de usuario do gcp que estará utilizando
}

output "vm-user" {
    value = var.vm-user
}