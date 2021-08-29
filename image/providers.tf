terraform {
  required_providers {
    docker = {
      source  = "terraform-providers/docker"  # from Terraform v 0.14+ the terraform-providers has been replaced with kreuzwerker
      version = "~> 2.7.2" # will ensure it as a minimum required version of docker to run script
    }
  }
}

provider "docker" {}
