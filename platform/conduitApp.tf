resource "kubernetes_namespace" "conduitApp" {
  metadata {
    name = "conduit-app"
  }
}

resource "helm_release" "conduitDb" {
  name       = "database"
  repository = "https://cloudnative-pg.github.io/charts"
  chart      = "cloudnative-pg"
  namespace  = "conduit-app"

  depends_on = [
    kubernetes_namespace.conduitApp
  ]
}

resource "kubernetes_manifest" "psqlInitCredentials" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Secret"
    "type"       = "kubernetes.io/basic-auth"
    "metadata" = {
      "name"      = "database-initcreds"
      "namespace" = "conduit-app"
    }

    "data" = {
        "username" = "YXBw" # must be "app"
        "password" = "Y29uZHVpN0RhN2FiYXMzUHIwZFVTM3JQYVNTdzByZA=="
    }
  }
}

resource "kubernetes_manifest" "psqlCluster" {
  manifest = {
    "apiVersion" = "postgresql.cnpg.io/v1"
    "kind"       = "Cluster"
    "metadata" = {
      "name"      = "database"
      "namespace" = "conduit-app"
    }

    "spec" = {
      "instances" = "1"
      "primaryUpdateStrategy" = "unsupervised"
      
      "storage" = {
        "size" = "4Gi"
      }

      "bootstrap" = {
        "initdb" = {
            "database" = "app"
            "owner" = "app"
            "secret" = {
                "name" = "database-initcreds"
            }
        }
      }

       "backup" = {
            "barmanObjectStore" = {
                "googleCredentials" = {
                    "gkeEnvironment" = true
                }
            "destinationPath" = google_storage_bucket.databaseBackupBucket.url
           } 
        }

       "serviceAccountTemplate" = {
           "metadata" = {
                "annotations" = {
                    "iam.gke.io/gcp-service-account" = google_service_account.conduit.email
                }
           }
       }
    }
  }

  depends_on = [
    kubernetes_namespace.conduitApp,
    google_storage_bucket.databaseBackupBucket,
    kubernetes_manifest.psqlInitCredentials
  ]
}

resource "kubernetes_manifest" "psqlClusterBackup" {
  manifest = {
    "apiVersion" = "postgresql.cnpg.io/v1"
    "kind"       = "ScheduledBackup"
    "metadata" = {
      "name"      = "database-backup"
      "namespace" = "conduit-app"
    }

    "spec" = {
      "schedule" = "0 0 0 * * *"
      "backupOwnerReference" = "self"
      "immediate" = "true"
      
      "cluster" = {
        "name" = "database"
      }
    }
  }

  depends_on = [
    kubernetes_manifest.psqlCluster,
    google_storage_bucket_iam_member.bindingPsqlBucket
  ]
}

resource "google_storage_bucket" "databaseBackupBucket" {
  name          = "conduit-database-backup-${var.environment}"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "bindingPsqlBucket" {
  bucket = google_storage_bucket.databaseBackupBucket.name
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.conduit.email}"
}

resource "google_compute_address" "conduitBackendIp" {
  name          = "conduitbackendip"
  region        = "europe-west3"
  address_type  = "EXTERNAL"
}

resource "google_dns_record_set" "conduitBackend" {
  name         = "social.${var.environment}.${data.google_dns_managed_zone.env_dns_zone.dns_name}"
  managed_zone = data.google_dns_managed_zone.env_dns_zone.name
  type         = "A"
  ttl          = 10

  rrdatas = [google_compute_address.conduitBackendIp.address]
}

resource "kubernetes_deployment" "conduit_backend" {
  metadata {
    name      = "conduit-backend"
    namespace = "conduit-app"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "conduit-backend"
      }
    }

    template {
      metadata {
        name = "conduit-backend"

        labels = {
          app = "conduit-backend"
        }
      }

      spec {
        container {
          name  = "conduit-backend"
          image = "jakobyte1024/conduit-backend:sha-11632c4"
          image_pull_policy = "Always"

          env {
            name  = "SPRING_PROFILES_ACTIVE"
            value = "prod"
          }

          env {
            name = "DATABASE_USER"

            value_from {
              secret_key_ref {
                name = "database-initcreds"
                key  = "username"
              }
            }
          }

          env {
            name = "DATABASE_PASSWORD"

            value_from {
              secret_key_ref {
                name = "database-initcreds"
                key  = "password"
              }
            }
          }

          env {
            name  = "DATABASE_HOSTNAME"
            value = "database-rw"
          }

          env {
            name  = "DATABASE_PORT"
            value = "5432"
          }

          env {
            name  = "DATABASE_NAME"
            value = "app"
          }
        }

        restart_policy = "Always"
      }
    }
  }

  depends_on = [
    kubernetes_manifest.psqlCluster
  ]
}

resource "kubernetes_service" "conduit_backend" {
  metadata {
    name      = "conduit-backend"
    namespace = "conduit-app"
  }

  spec {
    port {
      port = 8080
    }
    load_balancer_ip = google_compute_address.conduitBackendIp.address

    selector = {
      app = "conduit-backend"
    }

    type = "LoadBalancer"
  }

  depends_on = [
    kubernetes_deployment.conduit_backend
  ]
}
