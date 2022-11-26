variable "project_id" {
    type = string
    default = "" #colocar o ID do projeto que estará utilizando aqui
}

output "project_id" { 
    value = var.project_id
}