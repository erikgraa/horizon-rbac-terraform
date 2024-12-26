terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
    }
  }
  required_version = ">= 0.13"
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
  api_timeout          = 10
}