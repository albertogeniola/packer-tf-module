resource "google_project_service" "services" {
  for_each = toset([
    "compute.googleapis.com" # Needed to create VMs and Disk images
  ])

  project = var.builder_project_id
  service = each.value
}