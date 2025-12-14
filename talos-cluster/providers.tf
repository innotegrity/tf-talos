terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.1"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }

    talos = {
      source  = "siderolabs/talos"
      version = "~> 0.9"
    }

    unifi = {
      source  = "ubiquiti-community/unifi"
      version = "~> 0.41"
    }
  }
}
