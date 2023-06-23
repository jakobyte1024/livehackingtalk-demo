provider "google" {
  project     = "thorsten-jakoby-tj-projekt"
  region      = "europe-west3-c"
  zone        = "europe-west3"
}

terraform {
  backend "gcs" {
    bucket  = "conduit-iac-prod"
    # prefix  = "step3-terraform/state"
  }
}

variable "environment" {
    # will be provided as environment variable.
}

variable "createPolicy" {
    # will be provided as environment variable.
}

provider "kubernetes" {
  host                     = "https://${data.google_container_cluster.primary.endpoint}"
  client_certificate       = base64decode(data.google_container_cluster.primary.master_auth.0.client_certificate)
  client_key               = base64decode(data.google_container_cluster.primary.master_auth.0.client_key)
  cluster_ca_certificate   = base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_container_cluster.primary.endpoint}"
    client_certificate     = base64decode(data.google_container_cluster.primary.master_auth.0.client_certificate)
    client_key             = base64decode(data.google_container_cluster.primary.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  }
}
