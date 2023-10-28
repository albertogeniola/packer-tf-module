# Terraform + Packer integration example
This repository shows a way of integrating packer within terraform, without using any custom or external terraform provider.

## Repository structure
This repository contains two main relevant folders:
- modules/packer_module
- example

The first one, `modules/poacker_module`, contains an example of a packer_module that can be customized to build a Google Compute Engine image.
The second one, `example`, contains a simple terraform project that shows how to use the module.

