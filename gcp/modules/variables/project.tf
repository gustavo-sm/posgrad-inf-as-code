variable "project_id" {
    type = string
    default = "prj-iac-369104" #colocar o ID do projeto que estará utilizando aqui
}

output "project_id" { 
    value = var.project_id
}