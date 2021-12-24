data "google_container_registry_image" "debian" {
  name = var.image_name #"debian"
}

output "gcr_location" {
  value = data.google_container_registry_image.debian.image_url
}