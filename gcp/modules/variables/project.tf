variable "project_id" {
    type = string
    default = "prj-iac-369104"
}

output "project_id" { 
    value = var.project_id
}