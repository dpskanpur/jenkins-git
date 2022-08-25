locals {
  project_id             = "jenkins-360411"
  ip_cidr_range          = "192.168.0.0/16"
  ip_cidr_range_secondry = "10.0.0.0/16"
  region                 = "us-central1"
  range_name             = "network-range"
  bool                   = "false"
}
provider "google" {
  project = local.project_id
}

resource "google_compute_subnetwork" "sub-network" {
  name          = "${local.project_id}-subnet"
  ip_cidr_range = local.ip_cidr_range
  region        = local.region
  network       = google_compute_network.network.id
  secondary_ip_range {
    range_name    = local.range_name
    ip_cidr_range = local.ip_cidr_range_secondry
  }
}
resource "google_compute_network" "network" {
  name                    = "${local.project_id}-vpc"
  auto_create_subnetworks = local.bool
}
