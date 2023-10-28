variable project_id {}
variable region {}
variable zone {}
variable network_project_id {}
variable network_name {}
variable subnet_name {}
variable image_name {}
variable target_image_family {}
variable source_image_family {
  default = null
}
variable source_image {
  default = null
}

source "googlecompute" "packed_image" {
  project_id              = var.project_id
  source_image_family     = var.source_image_family
  source_image            = var.source_image
  image_name              = "${var.image_name}-{{timestamp}}"
  image_family            = var.target_image_family
  image_storage_locations = [var.region]
  image_labels = {
    "os" : var.source_image_family
  }
  ssh_username       = "packer-sa"
  instance_name      = "packer-image-builder"
  zone               = var.zone
  network            = var.network_name
  subnetwork         = var.subnet_name
  network_project_id = var.network_project_id
  use_internal_ip    = true
  omit_external_ip   = true
  use_iap            = true
  use_os_login       = true
  metadata = {
    block-project-ssh-keys = "true"
  }
  tags = [var.source_image_family, "packer"]
}

build {
  sources = [
    "source.googlecompute.packed_image"
  ]

  provisioner "shell" {
    script = "./scripts/setup.sh"
  }

  provisioner "file" {
    source      = "./rootfs"
    destination = "/tmp"
  }

  provisioner "shell" {
    script = "./scripts/move_and_align_permissions.sh"
  }

  post-processor "manifest" { 
    output = ".manifest.json"
    strip_path = true
  }

  post-processor "shell-local" { 
    # Take the last build
    inline = [
      "jq -r '.builds[-1].artifact_id' .manifest.json > ../.image_version"
    ]
  }
}


