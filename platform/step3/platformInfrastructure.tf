data "google_dns_managed_zone" "env_dns_zone" {
  name = "nevervictimconsult-xyz"
}

data "google_service_account" "conduit" {
  account_id   = "conduit-sa-${var.environment}"
}

data "google_container_cluster" "primary" {
  name        = "conduit-k8s-${var.environment}"
}
