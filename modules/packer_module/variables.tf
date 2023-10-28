variable "builder_project_id" {
  description = "GCP Project ID to be used for building the packer image"
}

variable "builder_network_project_id" {
  description = "GCP Project ID of the network to be used for building the packer image. If omitted, the builder_project_id is used instead."
  default = null
}

variable "builder_network_name" {
  description = "GCP network name where to attache the builder instance"
  default     = "default"
}

variable "builder_subnet_name" {
  description = "GCP network name where to attache the builder instance"
  default     = "default"
}

variable "builder_region" {
  description = "GCP region where to spawn the builder VM"
}

variable "builder_zone" {
  description = "GCP zone where to spawn the builder VM"
}

variable "source_image_family" {
  description = "Image family to use as base image for the builder. Ignored if specified in conjunction with source_image (which takes precedence)"
  default = null
}

variable "source_image" {
  description = "Image to use as base image for the builder. If specified, takes over source_image_family parameter"
  default = null
}

variable "target_image_name" {
  description = "Name to assigne to the image"
}

variable "target_image_family" {
  description = "Family to assign to the built image"
}