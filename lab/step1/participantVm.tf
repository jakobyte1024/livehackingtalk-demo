resource "google_compute_network" "vpc_network" {
  name = "${var.labName}-vpc"
}

resource "google_compute_instance_from_machine_image" "participantVm" {
  provider = google-beta
  name     = "${var.labName}-participant-0"
  zone     = "europe-west3-c"

  source_machine_image = "projects/thorsten-jakoby-tj-projekt/global/machineImages/lhca-attackvm-base-1"

  // Override fields from machine image
  network_interface {
    network = google_compute_network.vpc_network.self_link
    network_ip = ""
  }

}