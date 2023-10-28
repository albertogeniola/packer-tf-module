locals {
  # Let's calculate the hash of all the contents of the packer directory.
  # We'll use this hash to determine if anything changed in the packer directory.
  packer_contents_hash        = md5(join(",", [for f in fileset("${path.module}/packer", "**") : filemd5("${path.module}/packer/${f}") if f != ".manifest.json"]))
  image_source_build_params   = var.source_image != null ? "-var source_image=${var.source_image}}" : "-var source_image_family=${var.source_image_family}"
  image_target_build_params   = "-var image_name=${var.target_image_name} -var target_image_family=${var.target_image_family}"
  builder_network_project_id  = var.builder_network_project_id == null ? var.builder_project_id : var.builder_network_project_id
}

# We'll use a random string suffix every time the packer contents change
resource "random_string" "image_suffix" {
  keepers = {
    "scripts_hashes" = local.packer_contents_hash
  }
  length  = 4
  special = false
  upper   = false
  numeric = false
}


# This is the resource that will trigger the packer image creation
resource "terraform_data" "packer_image" {
  triggers_replace = [local.packer_contents_hash, local.image_source_build_params, local.image_target_build_params]
  
  provisioner "local-exec" {
    when = create
    working_dir = "${path.module}/packer/"
    command     = "packer build ${local.image_source_build_params} ${local.image_target_build_params} -var region=${var.builder_region} -var project_id=${var.builder_project_id} -var zone=${var.builder_zone} -var network_project_id=${local.builder_network_project_id} -var network_name=${var.builder_network_name} -var subnet_name=${var.builder_subnet_name} image.pkr.hcl"
  }

  depends_on = [ google_project_service.services ]
}

data "local_file" "image_version" {
  filename = "${path.module}/.image_version"
  depends_on = [ terraform_data.packer_image ]
}