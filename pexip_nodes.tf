resource "google_compute_image" "pexip-node-image" {
  name = "${var.env_prefix}-pexip-node-gcp"
  timeouts {
    create = "20m"
  }
  raw_disk {
    source = "${var.pexipnode_image_url}"
  }
}

resource "google_compute_address" "pexip-node-na-public-ip" {
  name = "${var.env_prefix}-node-na-public-ip"
  region        = "${var.region_for_na}"
}

resource "google_compute_address" "pexip-node-eu-public-ip" {
  name = "${var.env_prefix}-node-eu-public-ip"
  region        = "${var.region_for_eu}"
}

resource "google_compute_address" "pexip-node-apac-public-ip" {
  name = "${var.env_prefix}-node-apac-public-ip"
  region        = "${var.region_for_apac}"
}

resource "google_compute_instance" "pexip-node-na" {
  name = "${var.env_prefix}-node-na"
  machine_type = "${var.pexipnode_machine_type}"
  zone = "${element(var.uszones, 0)}"
  tags = ["${var.env_prefix}-node-na", "pexip-conferencing", "pexip-provisioning"]
  timeouts {
    create = "10m"
  }
  boot_disk {
    initialize_params {
      image = "${google_compute_image.pexip-node-image.self_link}"
      type = "pd-ssd"
      size  = 150
    }
  }
  network_interface {
    subnetwork = "${google_compute_subnetwork.na-subnet.name}"
    address = "${cidrhost(var.na_cidr, 6)}"
    access_config {
          nat_ip = "${google_compute_address.pexip-node-na-public-ip.address}"
    }
  }
  
  metadata {
      ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
}

#region      = "europe-west1"
resource "google_compute_instance" "pexip-node-eu" {
  name = "${var.env_prefix}-node-eu"
  machine_type = "${var.pexipnode_machine_type}"
  zone = "${element(var.euzones, 0)}"
  tags = ["${var.env_prefix}-node-eu", "pexip-conferencing", "pexip-provisioning"]
  timeouts {
    create = "10m"
  }
  boot_disk {
    initialize_params {
      image = "${google_compute_image.pexip-node-image.self_link}"
      type = "pd-ssd"
      size  = 150
    }
  }
  network_interface {
    subnetwork = "${google_compute_subnetwork.eu-subnet.name}"
    address = "${cidrhost(var.eu_cidr, 5)}"
    access_config {
          nat_ip = "${google_compute_address.pexip-node-eu-public-ip.address}"
    }
  }
  
  metadata {
      ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
}


#region      = "asia-east1"
resource "google_compute_instance" "pexip-node-apac" {
  name = "${var.env_prefix}-node-apac"
  machine_type = "${var.pexipnode_machine_type}"
  zone = "${element(var.apzones, 0)}"
  tags = ["${var.env_prefix}-node-ap", "pexip-conferencing", "pexip-provisioning"]
  timeouts {
    create = "10m"
  }
  boot_disk {
    initialize_params {
      image = "${google_compute_image.pexip-node-image.self_link}"
      type = "pd-ssd"
      size  = 150
    }
  }
  network_interface {
    subnetwork = "${google_compute_subnetwork.apac-subnet.name}"
    address = "${cidrhost(var.apac_cidr, 5)}"
    access_config {
          nat_ip = "${google_compute_address.pexip-node-apac-public-ip.address}"
    }
  }
  
  metadata {
      ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
}