variable "vsphere_password" {
  type      = string
  ephemeral = true
  sensitive = true

  validation {
    condition     = length(var.vsphere_password) != 0
    error_message = "The vSphere password cannot be null"
  }
}

variable "vsphere_user" {
  type      = string
  ephemeral = true
  sensitive = true
  default   = "administrator@vsphere.local"
}

variable "vsphere_server" {
  type      = string
  sensitive = true
}

variable "horizon_vdi_compute_cluster" {
  type = string
}

variable "horizon_vdi_datacenter" {
  type      = string
  sensitive = false
}

variable "horizon_vdi_resource_pool" {
  type = string
}

variable "horizon_vdi_folder" {
  type = string
}

variable "horizon_vdi_network" {
  type = string
}

variable "horizon_vdi_datastore" {
  type = string
}

variable "horizon_serviceaccount_instant_clone" {
  type = string
}