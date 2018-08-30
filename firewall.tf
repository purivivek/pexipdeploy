resource "google_compute_firewall" "pexip-allow-conferencing" {
  name    = "${var.env_prefix}-pexip-allow-conferencing"
  network = "${google_compute_network.pexip-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  allow {
    protocol = "tcp"
    ports    = ["5060"]
  }

  allow {
    protocol = "tcp"
    ports    = ["5061"]
  }

  allow {
    protocol = "tcp"
    ports    = ["1720"]
  }

  allow {
    protocol = "tcp"
    ports    = ["33000-39999"]
  }

  allow {
    protocol = "tcp"
    ports    = ["40000-49999"]
  }

  allow {
    protocol = "udp"
    ports    = ["1719"]
  }

  allow {
    protocol = "udp"
    ports    = ["33000-39999"]
  }

  allow {
    protocol = "udp"
    ports    = ["40000-49999"]
  }

  allow {
    protocol = "udp"
    ports    = ["5060"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["pexip-conferencing"]
}

resource "google_compute_firewall" "default-allow-internal" {
  name    = "${var.env_prefix}-default-allow-internal"
  network = "${google_compute_network.pexip-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "esp"
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "pexip-allow-provisioning" {
  name    = "${var.env_prefix}-pexip-allow-provisioning"
  network = "${google_compute_network.pexip-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["8443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["pexip-provisioning"]
}

resource "google_compute_firewall" "pexip-allow-management" {
  name    = "${var.env_prefix}-pexip-allow-management"
  network = "${google_compute_network.pexip-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["pexip-management"]
}

resource "google_compute_firewall" "pexip-allow-ssh" {
  name    = "${var.env_prefix}-pexip-allow-ssh"
  network = "${google_compute_network.pexip-network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  # Please change the source ip to a single ip or outbound proxy
  source_ranges = ["0.0.0.0/0"]
}