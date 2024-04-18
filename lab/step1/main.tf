provider "google" {
  project     = "thorsten-jakoby-tj-projekt"
  region      = "europe-west3-c"
  zone        = "europe-west3"
}

provider "google-beta" {
  project     = "thorsten-jakoby-tj-projekt"
  region      = "europe-west3-c"
  zone        = "europe-west3"
}

terraform {
  backend "gcs" {
    bucket  = "conduit-iac-prod"
    # prefix  = "step1-terraform/state"
  }
}

variable "labName" {
    # will be provided as environment variable.
}

variable "participantCount" {
    # will be provided as environment variable.
}
