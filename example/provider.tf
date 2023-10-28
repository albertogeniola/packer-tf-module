/**
 * Author: Alberto Geniola, geniola@google.com
 * Date: 2023/10/28
 *
 * Provider setup.
 * Backend is GCE, configured via backend.conf, which is not pushed to the repo.
 **/

provider "google" {}
provider "google-beta" {}
terraform {
  required_providers {
    google-beta = "4.84.0"
    google      = "4.84.0"
  }
  backend "gcs" {}  # Using "terraform init -backend-config=backend.conf", so that we don't need to push backend-configuration in our repo
}

