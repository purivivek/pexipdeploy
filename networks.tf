resource "google_compute_network" "pexip-network" {
  name = "${var.env_prefix}-virt-net"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "na-subnet" {
  name          = "${var.env_prefix}-subnet-na"
  ip_cidr_range = "${var.na_cidr}"
  network       = "${google_compute_network.pexip-network.self_link}"
  region        = "${var.region_for_na}"
  private_ip_google_access=true
}

resource "google_compute_subnetwork" "eu-subnet" {
  name          = "${var.env_prefix}-subnet-eu"
  ip_cidr_range = "${var.eu_cidr}"
  network       = "${google_compute_network.pexip-network.self_link}"
  region        = "${var.region_for_eu}"
  private_ip_google_access=true
}

resource "google_compute_subnetwork" "apac-subnet" {
  name          = "${var.env_prefix}-subnet-apac"
  ip_cidr_range = "${var.apac_cidr}"
  network       = "${google_compute_network.pexip-network.self_link}"
  region        = "${var.region_for_apac}"
  private_ip_google_access=true
}
