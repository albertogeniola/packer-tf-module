# Terraform + Packer integration example
This repository shows a way of integrating packer within terraform, without using any custom or external terraform provider.

## Repository structure
This repository contains two main relevant folders:
- modules/packer_module
- example

The first one, `modules/poacker_module`, contains an example of a packer_module that can be customized to build a Google Compute Engine image.
The second one, `example`, contains a simple terraform project that shows how to use the module.

## Usage example
You can find a complete example in the `example` folder. However, for a quick start, you can simply do the following:
1. Download the module named "packer_module" and put it into your /modules folder within your terraform project
2. Declare the module into your terraform project and fill in the module parameters as necessary
3. Run `terraform init`
4. Run `terraform apply`

Here there is an example:

```hcl
module "my_packer_image" {
  source = "<PATH_TO_THE_DOWNLOADED_MODULE>"

  builder_project_id = "my-gcp-project-id"  # Replace it with your GCP project id
  builder_region     = "europe-west3"       # Specify the GCP region and zone 
  builder_zone       = "europe-west3-b"     #  where to spawn the builder VM

  source_image_family = "debian-11"         # Image family to build from
  target_image_name   = "my-image"          # Name and family name to assign 
  target_image_family = "test"              #  to the built image

  builder_network_name = "random-tests"     # Network and subnet names 
  builder_subnet_name = "random-frankfurt"  #  for the builder VM
}
```