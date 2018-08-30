resource "google_compute_image" "pexip-mgmt-image" {
  name = "${var.env_prefix}-pexip-mgr-gcp"
  timeouts {
    create = "20m"
  }
  raw_disk {
    source = "${var.pexipman_image_url}"
  }
}

resource "google_compute_address" "pexip-mgmt-public-ip" {
  name = "${var.env_prefix}-mgr-public-ip"
}

resource "google_compute_instance" "pexip-mgmt" {
  name = "${var.env_prefix}-pexip-mgmt"
  machine_type = "${var.pexipman_machine_type}"
  zone = "${element(var.uszones, 0)}"
  tags = ["${var.env_prefix}-pexipmgr", "pexip-management", "allow-ssh"]
  timeouts {
    create = "10m"
  }
  boot_disk {
    initialize_params {
      image = "${google_compute_image.pexip-mgmt-image.self_link}"
      type = "pd-ssd"
      size  = 150
    }
  }
  network_interface {
    subnetwork = "${google_compute_subnetwork.na-subnet.name}"
    address = "${cidrhost(var.na_cidr, 5)}"
    access_config {
          nat_ip = "${google_compute_address.pexip-mgmt-public-ip.address}"
    }
  }
  
  metadata {
      ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
}
