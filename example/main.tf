/**
 * Author: Alberto Geniola, geniola@google.com
 * Date: 2023/10/28
 *
 * Main file.
 * Initializes our custom packer image via its dedicated module.
 **/


module "my_packer_image" {
  source = "../modules/packer_module"

  builder_project_id = var.project_id
  builder_region     = "europe-west3"
  builder_zone       = "europe-west3-b"

  source_image_family = "debian-11"
  target_image_name   = "my-image"
  target_image_family = "test"

  builder_network_name = "random-tests"
  builder_subnet_name = "random-frankfurt"
}