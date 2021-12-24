provider "google" {
  project = var.project_id
  region  = var.region
}


terraform {
  required_providers {
    docker = {
source  = "kreuzwerker/docker"
version = "2.11.0"
    }
  }
}
provider "docker" {
  # Configuration options
}