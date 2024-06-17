resource "google_compute_network" "vpc_network" {
  name                    = "conduit-network-${var.environment}"
  auto_create_subnetworks = "true"
}

data "google_dns_managed_zone" "env_dns_zone" {
  name = "nevervictimconsult-xyz"
}

resource "google_service_account" "conduit" {
  account_id   = "conduit-sa-${var.environment}"
  display_name = "conduit-sa-${var.environment}t"
}


resource "google_container_cluster" "primary" {
  name                      = "conduit-k8s-${var.environment}"
  remove_default_node_pool  = true
  initial_node_count        = 1
  network                   = google_compute_network.vpc_network.self_link
  enable_legacy_abac        = true
  deletion_protection       = false
  master_auth {
    client_certificate_config {
        issue_client_certificate = true
        }
    }
    release_channel {
      channel = "STABLE"
    }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "np-tf"
  cluster    = google_container_cluster.primary.id
  node_count = 5
  node_locations = ["europe-west3-c"]

  node_config {
    preemptible  = false
    machine_type = "e2-medium"

    service_account = google_service_account.conduit.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
