variable "network" {
    type = string
    default = "default"
}

output "network" {
    value = var.network
}