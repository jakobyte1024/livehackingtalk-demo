data "google_dns_managed_zone" "env_dns_zone" {
  name = "nevervictimconsult-xyz"
}

data "google_service_account" "conduit" {
  account_id   = "conduit-sa-${var.environment}"
}

data "google_container_cluster" "primary" {
  name        = "conduit-k8s-${var.environment}"
}

resource "google_compute_address" "ingressIp" {
  name          = "ingressip${var.environment}"
  region        = "europe-west3"
  address_type  = "EXTERNAL"
}


