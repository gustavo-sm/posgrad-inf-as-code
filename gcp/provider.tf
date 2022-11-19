module "variables" {
    source = "./modules/variables"
}
provider "google" {
    credentials = "${pathexpand("~/.gcp/credentials.json")}"
    region = module.variables.region_central
    zone = module.variables.zone_centralb
    project = module.variables.project_id
}