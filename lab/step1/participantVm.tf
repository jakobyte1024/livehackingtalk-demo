resource "google_compute_network" "vpc_network" {
  name = "${var.labName}-vpc"
}

resource "google_compute_firewall" "labfirewall" {
  name    = "${var.labName}-vpc-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "443", "3389"]
  }
}

resource "google_compute_instance_from_machine_image" "participantVm" {
  provider = google-beta
  name     = "${var.labName}-participant-${count.index}"
  zone     = "europe-west3-c"
  count    = var.participantCount

  source_machine_image = "projects/thorsten-jakoby-tj-projekt/global/machineImages/lhca-attackvm-base-1"

  // Override fields from machine image
  network_interface {
    network = google_compute_network.vpc_network.self_link
    network_ip = ""

    access_config {}
  }
}
