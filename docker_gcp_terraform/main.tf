module "gcr" {
   source = "./pull_image"
   image_name = var.image_name
   project_id = var.project_id
   region = var.region
}

module "docker_launch" {
   source = "./docker_launch"
   application_name = var.application_name
   image_name = var.image_name
   gcr_location = module.gcr.gcr_location
}