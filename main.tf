terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
    }

    doormat = {
      source  = "doormat.hashicorp.services/hashicorp-security/doormat"
      version = "~> 0.0.2"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "sandraliu-training"

    workspaces {
      name = "demo-gcp"
    }
  }
}

provider "doormat" {}

data "doormat_gcp_credentials" "creds" {
  provider = doormat

  service_account = "sandra@hashicorp.com"
  project_id      = "hc-3ffaca91386f4ab9b0ec6dc8f23"
}

provider "google" {
  access_token = data.doormat_gcp_credentials.creds.access_token
  project      = "hc-3ffaca91386f4ab9b0ec6dc8f23"
}
